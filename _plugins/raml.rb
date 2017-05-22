require 'raml_parser'
require 'raml_parser/snippet_generator'

module Jekyll
  class ApiResourcePage < Page
    def initialize(site, base, dir, key_prefix, raml, raml_resource, raml_method)
      slugified = Jekyll::Utils::slugify("#{raml_method.method}-#{raml_resource.relative_uri}")

      @site = site
      @base = base
      @dir = dir
      @name = slugified + '.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'resource.html')

      self.data['key'] = key_prefix + slugified + '-information'
      self.data['title'] = raml_resource.display_name
      self.data['category'] = 'raml'

      self.data['raml'] = RamlLiquidifyer.new(raml)
      self.data['raml_resource'] = RamlLiquidifyer.new(raml_resource)
      self.data['raml_method'] = RamlLiquidifyer.new(raml_method)

      snippet_generator = RamlParser::SnippetGenerator.new(raml)
      self.data['raml_snippets'] = [
        {
          'title' => 'CURL',
          'snippet' => begin
            snippet_generator.curl(raml_resource, raml_method.method.downcase)
          rescue
            ''
          end
        },
        {
          'title' => 'JavaScript',
          'snippet' => begin
            snippet_generator.javascript_vanilla(raml_resource, raml_method.method.downcase)
          rescue
            ''
          end
        },
        {
          'title' => 'Ruby',
          'snippet' => begin
            snippet_generator.ruby(raml_resource, raml_method.method.downcase)
          rescue
            ''
          end
        }
      ]
    end
  end

  class ApiResourcePageGenerator < Generator
    def generate(site)
      site.config['raml'].each do |raml_config|
        api_versions = Dir["#{raml_config['api_versions']}"]
        api_versions.each { |version| site.pages += pages_generator(site, version, raml_config).flatten }
      end
    end

    def pages_generator(site, version, raml_config)
      dest = "apps/#{version.split('/')[1].match(/v-.+/).to_s}/api-reference/"
      path = File.join(site.source, version)
      result = RamlParser::Parser.parse_file_with_marks(path)
      raml = result[:root]
      not_used = result[:marks].select { |_,m| m != :used }
      not_used.each { |p,m| puts "#{m} #{p}" }
      raml.resources.map { |res|
        res.methods.map { |_,meth|
          ApiResourcePage.new(site, site.source, dest, raml_config['key_prefix'], raml, res, meth)
        }
      }
    end
  end

  class RamlPage < Page
    def initialize(site, base, dir, key_prefix, raml_raw)
      @site = site
      @base = base
      @dir = dir
      @name = 'api.raml'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'api.raml')

      self.data['key'] = key_prefix + '-raml-file'
      self.data['searchable'] = false
      self.data['raml_raw'] = raml_raw
    end
  end

  class RamlPageGenerator < Generator
    def generate(site)
      site.config['raml'].each do |raml_config|
        path = File.join(site.source, raml_config['root_file'])
        raml_raw = RamlParser::YamlHelper.dump_yaml(RamlParser::YamlHelper.read_yaml(path))

        site.pages << RamlPage.new(site, site.source, raml_config['url_prefix'], raml_config['key_prefix'], raml_raw)
      end
    end
  end

  class RamlLiquidifyer
    ACCESSOR_MAP = {
      RamlParser::Model::Root => %w(title base_uri version media_type schemas security_schemes base_uri_parameters resource_types traits secured_by documentation resources),
      RamlParser::Model::Resource => %w(absolute_uri relative_uri display_name description base_uri_parameters uri_parameters methods type is secured_by),
      RamlParser::Model::Method => %w(method description query_parameters responses bodies headers is secured_by),
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
