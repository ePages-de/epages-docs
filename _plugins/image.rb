module Jekyll
  class ImageBlock < Liquid::Block
    def initialize(tag_name, data, tokens)
      super

      if data.strip =~ /^([^\s]+)( ([^\s]+))?$/
        @url = $1
        @width = $3
      else
        raise 'ImageBlock must be used with "filename [width]"'
      end
    end

    def render(context)
      url = if not @url =~ /^https?:\/\// then context.registers[:site].baseurl + '/assets/images/' + @url else @url end
      caption = super.to_s

      width_html = unless @width.nil? then "width=\"#{@width}\"" else '' end
      image_html = "<image src=\"#{url}\" alt=\"Image could not be loaded\" #{width_html}/>"
      caption_html = if caption != '' then "<label>#{caption}</label>" else '' end
      "<div class=\"imagebox\">#{image_html}#{caption_html}</div>"
    end
  end
end

Liquid::Template.register_tag('image', Jekyll::ImageBlock)
