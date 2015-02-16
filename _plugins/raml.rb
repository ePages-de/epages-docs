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
      path = File.join(site.source, site.config['raml_root'])
      result = RamlParser::Parser.parse_file_with_marks(path)
      raml = result[:root]
      not_used = result[:marks].select { |_,m| m != :used }
      not_used.each { |p,m| puts "#{m} #{p}" }

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
      RamlParser::Model::Root => %w(title base_uri version media_type security_schemes secured_by resources documentation),
      RamlParser::Model::Resource => %w(absolute_uri relative_uri display_name description uri_parameters methods type is secured_by),
      RamlParser::Model::Method => %w(method display_name description query_parameters responses bodies headers is secured_by),
      RamlParser::Model::Response => %w(status_code display_name description bodies headers),
      RamlParser::Model::Body => %w(media_type example schema form_parameters),
      RamlParser::Model::NamedParameter => %w(name type display_name description required default example min_length max_length minimum maximum repeat enum pattern),
      RamlParser::Model::Documentation => %w(title content),
      RamlParser::Model::SecurityScheme => %w(name type description described_by settings)
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
