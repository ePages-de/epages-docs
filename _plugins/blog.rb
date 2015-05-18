require 'raml_parser'

module Jekyll
  class BlogCategoryPage < Page
    def initialize(site, base, dir, category, posts)
      @site = site
      @base = base
      @dir = dir
      @name = category + '.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'category.html')
      self.data['key'] = 'blog-category-' + category
      self.data['searchable'] = false
      self.data['posts'] = posts
    end
  end

  class BlogCategoryPageGenerator < Generator
    def generate(site)
      categories = site.posts.inject([]) { |acc, post| acc |= (post.categories || []) }
      categories.each do |category|
        posts = site.posts.select { |p| (p.categories || []).include? category }.sort { |a,b| b <=> a }
        site.pages << BlogCategoryPage.new(site, site.source, 'blog/categories', category, posts)
      end
    end
  end
end
