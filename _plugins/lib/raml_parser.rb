##
## Copyright 2015 Christian Hoffmeister <mail@choffmeister.de>
##
class RamlParser
  def initialize(unknown_handling = 'error')
    @error_handling = unknown_handling
  end

  def parse_file(path)
    create_root(YamlHelper.read_yaml(path))
  end

  def create_root(node)
    root = RamlRoot.new

    (node || {}).select { |_,v| v }.each { |k,v|
      case k
        when 'title'
          root.title = v
        when 'baseUri'
          root.base_uri = v
        when 'version'
          root.version = v
        when 'traits'
          root.traits = Hash[v.map { |t| t.first }]
        when /^\//
          # start traversing with a base resource that gets further
          # specified deeper down the RAML tree
          base_resource = RamlResource.new
          base_resource.uri = root.base_uri + k
          root.resources += create_resources(v, root, base_resource)
        else
          error("Unknown key '#{k}'", node)
      end
    }

    root
  end

  def create_resources(node, root, base_resource)
    resources = []

    puts node if node.is_a? String
    (node || {}).select { |_,v| v }.each { |k,v|
      case k
        when 'displayName'
          base_resource.display_name = v
        when 'description'
          base_resource.description = v
        when 'uriParameters'
          base_resource.uri_parameters += v.map { |k2,v2| create_named_parameter(v2, root, k2) }
        when 'queryParameters'
          base_resource.query_parameters += v.map { |k2,v2| create_named_parameter(v2, root, k2) }
        when 'responses'
          base_resource.responses += v.map { |k2,v2| create_response(v2, root, k2) }
        when 'is'
          v.each { |t|
            if t.is_a? String and root.traits[t]
              root.traits[t].each { |k2,v2|
                case k2
                  when 'displayName'
                    base_resource.display_name = v2
                  when 'description'
                    base_resource.description = v2
                  when 'uriParameters'
                    base_resource.uri_parameters += v2.map { |k3,v3| create_named_parameter(v3, root, k3) }
                  when 'queryParameters'
                    base_resource.query_parameters += v2.map { |k3,v3| create_named_parameter(v3, root, k3) }
                  when 'responses'
                    base_resource.responses += v2.map { |k3,v3| create_response(v3, root, k3) }
                  else
                    error("Mixing in #{k2} is supported yet", node)
                end
              }
            elsif t.is_a? String and not root.traits[t]
              error("Could not find trait #{t}", node)
            else
              error("Parametrized traits are not supported yet", node)
            end
          }
        when /^\//
          resources += create_resources(v, root, base_resource.clone_with { |r| r.uri += k })
        when /get|post|put|delete/
          resources += create_resources(v, root, base_resource.clone_with { |r| r.method = k })
        else
          error("Unknown key '#{k}'", node)
      end
    }

    resources << finalize_resource(base_resource, root) if base_resource.uri and base_resource.method
    resources
  end

  def create_named_parameter(node, root, name)
    named_parameter = RamlNamedParameter.new
    named_parameter.name = name

    (node || {}).select { |_,v| v }.each { |k,v|
      case k
        when 'displayName'
          named_parameter.display_name = v
        when 'description'
          named_parameter.description = v
        when 'type'
          named_parameter.type = v
        when 'required'
          named_parameter.required = v
        when 'default'
          named_parameter.default = v
        when 'example'
          named_parameter.example = v
        when 'minimum'
          named_parameter.minimum = v
        when 'maximum'
          named_parameter.maximum = v
        when 'repeat'
          named_parameter.repeat = v
        when 'enum'
          named_parameter.enum = v
        else
          error("Unknown key '#{k}'", node)
      end
    }

    named_parameter
  end

  def create_response(node, root, status_code)
    response = RamlResponse.new
    response.status_code = status_code

    (node || {}).select { |_,v| v }.each { |k,v|
      case k
        when 'description'
          response.description = v
        else
          error("Unknown key '#{k}'", node)
      end
    }

    response
  end

  def finalize_resource(resource, root)
    resource.display_name = resource.uri[root.base_uri.length..-1] unless resource.display_name
    resource.uri = resource.uri.gsub(/([^:])\/{2,}/, '\1/')

    resource.uri_parameters += resource.uri.scan(/\{([a-zA-Z]+)\}/)
      .map { |m| m.first }
      .select { |up_name| not resource.uri_parameters.find { |up| up.name == up_name } }
      .map { |up_name|
        up = RamlNamedParameter.new
        up.name = up_name
        up
      }

    resource.uri_parameters.each { |up| finalize_name_parameter(up, root, true) }
    resource.query_parameters.each { |qp| finalize_name_parameter(qp, root, false) }

    resource
  end

  def finalize_name_parameter(named_parameter, root, required_default)
    named_parameter.display_name = named_parameter.name unless named_parameter.display_name
    named_parameter.type = 'string' unless named_parameter.type
    named_parameter.repeat = false unless named_parameter.repeat
    named_parameter.required = required_default unless named_parameter.required
  end

  def error(message, node)
    case @error_handling
      when 'ignore'
      when 'warning'
        puts "Warning: '#{message}'"
      else
        raise "Error: '#{message}'"
    end
  end
end

class RamlRoot
  attr_accessor :title, :base_uri, :version, :traits, :resources

  def initialize
    @title = '(unnamed)'
    @base_uri = ''
    @traits = {}
    @resources = []
  end

  def to_liquid
    {
      'title' => @title,
      'base_uri' => @base_uri,
      'version' => @version,
      'resources' => @resources.map { |r| r.to_liquid }
    }
  end
end

class RamlResource
  attr_accessor :method, :uri, :display_name, :description, :uri_parameters, :query_parameters, :responses

  def initialize
    @uri_parameters = []
    @query_parameters = []
    @responses = []
  end

  def clone_with(&code)
    cloned = self.clone
    code.call(cloned)
    cloned
  end

  def to_liquid
    {
      'method' => @method,
      'uri' => @uri,
      'display_name' => @display_name,
      'description' => @description,
      'uri_parameters' => @uri_parameters.map { |r| r.to_liquid },
      'query_parameters' => @query_parameters.map { |r| r.to_liquid },
      'responses' => @responses.map { |r| r.to_liquid }
    }
  end
end

class RamlNamedParameter
  attr_accessor :name, :display_name, :description, :type, :required, :default, :example, :minimum, :maximum, :repeat, :enum

  def to_liquid
    {
      'name' => @name,
      'display_name' => @display_name,
      'description' => @description,
      'type' => @type,
      'required' => @required,
      'default' => @default,
      'example' => @example,
      'minimum' => @minimum,
      'maximum' => @maximum,
      'repeat' => @repeat,
      'enum' => @enum
    }
  end
end


class RamlResponse
  attr_accessor :status_code, :description

  def to_liquid
    {
      'status_code' => @status_code,
      'description' => @description
    }
  end
end
