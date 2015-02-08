module Jekyll
  class ApiResourcePage < Page
    def initialize(site, base, dir, raml, raml_resouce)
      short_uri = raml_resouce.uri[raml.base_uri.length..-1]
      slugified = Jekyll::Utils::slugify("#{raml_resouce.method}-#{short_uri}")

      @site = site
      @base = base
      @dir = dir
      @name = slugified + '.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'resource.html')

      self.data['title'] = raml_resouce.display_name
      self.data['category'] = 'raml'

      self.data['raml'] = raml
      self.data['raml_resource'] = raml_resouce
    end
  end

  class ApiResourcePageGenerator < Generator
    def generate(site)
      parser = RamlParser.new('ignore')
      path = File.join(site.source, site.config['raml_root'])
      raml = parser.parse_file(path)

      site.pages += raml.resources.map { |res|
        ApiResourcePage.new(site, site.source, 'resources', raml, res)
      }
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
      raml_raw = YamlHelper.dump_yaml(YamlHelper.read_yaml(path))

      site.pages << RamlPage.new(site, site.source, 'resources', raml_raw)
    end
  end
end
