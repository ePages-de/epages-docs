module Jekyll
  class LinkTag < Liquid::Tag
    def initialize(tag_name, data, tokens)
      super

      /([a-z\-]+):([a-z\-]+)(#([a-z\-]+))?(\s+(.*))?/.match(data.strip)
      @type = $1
      @key = $2
      @anchor = $4
      @title = $6
    end

    def render(context)
      if not @type.nil? and not @key.nil?
        case @type
          when 'page'
            page = context.registers[:site].pages.detect { |page| page.data['key'] == @key }

            if not page.nil?
              url = context.registers[:site].baseurl + page.url
              anchor = if not @anchor.nil? and @anchor.strip then '#' + @anchor.strip else '' end
              title = if not @title.nil? and @title.strip != '' then @title.strip else page.data['title'] end

              p "<a href=\"#{url}#{anchor}\">#{title}</a>"
              "<a href=\"#{url}#{anchor}\">#{title}</a>"
            else
              raise "Could not find page with key '#{@key}'"
            end
          else
            raise "Unknown link type '#{@type}'"
        end
      else
        raise "Could not parse link format '#{data.strip}'"
      end
    end
  end
end

Liquid::Template.register_tag('link', Jekyll::LinkTag)
