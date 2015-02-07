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

      Dir.glob(File.join(site.source, site.config['raml_root'])).each { |path|
        raml = parser.parse_file(path)
        site.pages += raml.resources.map { |res|
          ApiResourcePage.new(site, site.source, 'resources', raml, res)
        }
      }
    end
  end
end
