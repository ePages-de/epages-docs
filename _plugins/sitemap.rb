require 'loofah'

class Sitemap
  def self.resolve(site, ref)
    if ref.strip =~ /([a-z\-]+):([a-z\-]+)(#([a-z\-]+))?/
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
        else
          Jekyll.logger.error 'Unknown reference type:' "Unknown link type '#{type}'"
          nil
      end
    else
      Jekyll.logger.error 'Unknown reference format:' "Do not understand reference '#{ref}'"
      nil
    end
  end
end

module Jekyll
  class SitemapLinkTag < Liquid::Tag
    def initialize(tag_name, data, tokens)
      @data = data
      super
    end

    def render(context)
      @ref = lookup(context, @data)

      url = Sitemap.resolve(context.registers[:site], @ref['link'])
      render_link(url, @ref['title'])
    end

    private

    def render_link(url, title)
      if url != nil
        "<a href=\"#{url}\">#{title}</a>"
      else
        "<a href=\"/this-link-leads-to-nowhere.html\">UNRESOLVED LINK</a>"
      end
    end

    def lookup(context, name)
      name.split(".").each do |value|
        context = context[value]
      end
      context
    end
  end
end

Liquid::Template.register_tag('sitemap_link', Jekyll::SitemapLinkTag)
