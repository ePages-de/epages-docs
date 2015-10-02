require 'raml_parser'

module Jekyll
  class BlogPostGroupPage < Page
    def initialize(site, base, dir, name, key_suffix, posts, paginator = nil)
      @site = site
      @base = base
      @dir = dir
      @name = name + '.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'post-group.html')
      self.data['key'] = 'blog-' + key_suffix
      self.data['searchable'] = false
      self.data['posts'] = posts
      self.data['paginator'] = {}

      paginator.keys.each do |key|
        self.data['paginator'][key.to_s] = paginator[key]
      end
      unless self.data['paginator'].nil?
        if self.data['paginator']['page'] > 1
          self.data['paginator']['previous_page'] = self.data['paginator']['page'] - 1
          if self.data['paginator']['previous_page'] == 1
            self.data['paginator']['previous_page_path'] = "/#{dir[0..-7]}"
          else
            self.data['paginator']['previous_page_path'] = self.data['paginator']['base_path'] + self.data['paginator']['previous_page'].to_s
          end
        end
        if self.data['paginator']['page'] < self.data['paginator']['total_pages']
          self.data['paginator']['next_page'] = self.data['paginator']['page'] + 1
          self.data['paginator']['next_page_path'] = self.data['paginator']['base_path'] + self.data['paginator']['next_page'].to_s
        end
      end
    end
  end

  class BlogPostGroupPageGenerator < Generator
    def generate(site)
      post_per_page = site.config["paginate"]
      categories = site.posts.inject([]) { |acc, post| acc |= (post.categories || []) }

      categories.each do |category|
        posts = site.posts.select { |p| (p.categories || []).include? category }.sort { |a,b| b <=> a }
        1.upto (posts.size.to_f / post_per_page).ceil do |page|
          paginator = { page: page, total_pages: (posts.size.to_f / post_per_page).ceil, base_path: "/blog/categories/#{category}/page-" }
          dir = page == 1 ? "blog/categories/#{category}" : "blog/categories/#{category}/page-#{page}"
          site.pages << BlogPostGroupPage.new(site, site.source, dir, 'index', "category-#{category}", posts.shift(post_per_page), paginator)
        end
      end

      tags = site.posts.inject([]) { |acc, post| acc |= (post.tags || []) }
      tags.each do |tag|
        posts = site.posts.select { |p| (p.tags || []).include? tag }.sort { |a,b| b <=> a }
        site.pages << BlogPostGroupPage.new(site, site.source, 'blog/tags', tag, 'tag-' + tag, posts)
      end
    end
  end
end
