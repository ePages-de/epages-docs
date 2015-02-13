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

      self.data['raml'] = raml.to_hash
      self.data['raml_resource'] = raml_resource.to_hash
      self.data['raml_method'] = raml_method.to_hash
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
end
