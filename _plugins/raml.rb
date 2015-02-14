require 'raml_parser'

module Jekyll
  class ApiResourcePage < Page
    def initialize(site, base, dir, raml, raml_resource, raml_method)
      slugified = Jekyll::Utils::slugify("#{raml_method.method}-#{raml_resource.relative_uri}")

      @site = site
      @base = base
      @dir = dir
      @name = slugified + '.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'resource.html')

      self.data['title'] = raml_resource.display_name
      self.data['category'] = 'raml'

      self.data['raml'] = RamlLiquidifyer.new(raml)
      self.data['raml_resource'] = RamlLiquidifyer.new(raml_resource)
      self.data['raml_method'] = RamlLiquidifyer.new(raml_method)
    end
  end

  class ApiResourcePageGenerator < Generator
    def generate(site)
      parser = RamlParser::Parser.new({ :not_yet_supported => :ignore })
      path = File.join(site.source, site.config['raml_root'])
      raml = parser.parse_file(path)

      pages = raml.resources.map { |res|
        res.methods.map { |_,meth|
          ApiResourcePage.new(site, site.source, 'resources', raml, res, meth)
        }
      }
      site.pages += pages.flatten
    end
  end

  class RamlPage < Page
    def initialize(site, base, dir, raml_raw)
      @site = site
      @base = base
      @dir = dir
      @name = 'api.raml'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'api.raml')

      self.data['raml_raw'] = raml_raw
    end
  end

  class RamlPageGenerator < Generator
    def generate(site)
      path = File.join(site.source, site.config['raml_root'])
      raml_raw = RamlParser::YamlHelper.dump_yaml(RamlParser::YamlHelper.read_yaml(path))

      site.pages << RamlPage.new(site, site.source, 'resources', raml_raw)
    end
  end

  class RamlLiquidifyer
    ACCESSOR_MAP = {
      RamlParser::Model::Root => %w(title base_uri version resources),
      RamlParser::Model::Resource => %w(absolute_uri relative_uri display_name description uri_parameters methods),
      RamlParser::Model::Method => %w(method display_name description query_parameters responses),
      RamlParser::Model::Response => %w(status_code display_name description bodies),
      RamlParser::Model::Body => %w(media_type example schema),
      RamlParser::Model::NamedParameter => %w(name type display_name description required default example min_length max_length minimum maximum repeat enum pattern),
    }

    def initialize(obj)
      @obj = obj
    end

    def convert(node)
      if node == nil
        node
      elsif node == true or node == false
        node
      elsif node.is_a? String
        node
      elsif node.is_a? Integer
        node
      elsif node.is_a? Float
        node
      elsif node.is_a? Array
        node.map { |item| convert(item) }
      elsif node.is_a? Hash
        Hash[node.map { |key,value| [key, convert(value)] }]
      else
        Hash[ACCESSOR_MAP[node.class].map { |name| [name, convert(node.send(name))] }]
      end
    end

    def to_liquid
      convert(@obj)
    end
  end
end
