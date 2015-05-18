require 'raml_parser'

module Jekyll
  class BlogPostGroupPage < Page
    def initialize(site, base, dir, name, key_suffix, posts)
      @site = site
      @base = base
      @dir = dir
      @name = name + '.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'post-group.html')
      self.data['key'] = 'blog-' + key_suffix
      self.data['searchable'] = false
      self.data['posts'] = posts
    end
  end

  class BlogPostGroupPageGenerator < Generator
    def generate(site)
      categories = site.posts.inject([]) { |acc, post| acc |= (post.categories || []) }
      categories.each do |category|
        posts = site.posts.select { |p| (p.categories || []).include? category }.sort { |a,b| b <=> a }
        site.pages << BlogPostGroupPage.new(site, site.source, 'blog/categories', category, 'category-' + category, posts)
      end

      tags = site.posts.inject([]) { |acc, post| acc |= (post.tags || []) }
      tags.each do |tag|
        posts = site.posts.select { |p| (p.tags || []).include? tag }.sort { |a,b| b <=> a }
        site.pages << BlogPostGroupPage.new(site, site.source, 'blog/tags', tag, 'tag-' + tag, posts)
      end
    end
  end
end
