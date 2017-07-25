require 'loofah'

class Sitemap
  def self.resolve(ref)
    if ref.strip =~ /([a-z0-9\-]+):([a-z0-9\-]+)(#(.+))?/
      type = $1
      key = $2
      anchor = $4

      case type
        when 'page'
          page = site.pages.detect { |page| page.data['key'] == key }
          if page != nil
            if anchor.nil?
              site.baseurl + page.url
            else
              site.baseurl + page.url + '#' + anchor
            end
          else
            Jekyll.logger.warn 'Unknown reference:', "Could not find page with key '#{key}'"
            nil
          end
        when 'mailto'
          nil
        else
          Jekyll.logger.error 'Unknown reference type:' "Unknown link type '#{type}'"
          nil
      end
    else
      nil
    end
  end

  def self.get(name)
    site.data["sitemap-#{name}"]
  end

  private

  def self.site
    Jekyll.sites.last
  end
end

module Jekyll
  class HeadlineAnchorOffsetConverter < Converter
    priority :lowest

    def matches(ext)
      ext =~ /^\.(html|md)$/i
    end

    def output_ext(ext)
      ".html"
    end

    def convert(content)
      parse_special_links = Loofah::Scrubber.new do |node|
        if node.name =~ /h(1|2|3|4|5|6)/
          if node['id']
            id = node['id']
            node.remove_attribute('id')
            anchor = node.children.first.add_previous_sibling("<div id=\"#{id}\" class=\"headline-anchor\"></div>").first
          end
        end
      end

      Loofah.fragment(content).
        scrub!(parse_special_links).
        to_s
    end
  end

  class LinkConverter < Converter
    priority :lowest

    def matches(ext)
      ext =~ /^\.(html|md)$/i
    end

    def output_ext(ext)
      ".html"
    end

    def convert(content)
      parse_special_links = Loofah::Scrubber.new do |node|
        if node.name == 'a'
          if node['href'].strip =~ /([a-z0-9\-]+):([a-z0-9\-]+)(#(.+))?/
            resolved = Sitemap.resolve(node['href'])
            node['href'] = resolved unless resolved.nil?
          end
        end
      end

      Loofah.fragment(content).
        scrub!(parse_special_links).
        to_s
    end
  end

  class SitemapLinkTag < Liquid::Tag
    def initialize(tag_name, data, tokens)
      @data = data
      super
    end

    def render(context)
      @ref = lookup(context, @data)

      title = @ref['title'] || 'UNKNOWN TITLE'
      url = Sitemap.resolve(@ref['link']) || @ref['link']
      c_class = @ref['class'] || ''
      "<a class=\"#{c_class}\" href=\"#{url}\">#{title}</a>"
    end

    private

    def lookup(context, name)
      name.split(".").each do |value|
        context = context[value]
      end
      context
    end
  end

  module SitemapFilters
    def sitemap(name)
      Sitemap.get(name)
    end
  end
end

Liquid::Template.register_tag('sitemap_link', Jekyll::SitemapLinkTag)
Liquid::Template.register_filter(Jekyll::SitemapFilters)
