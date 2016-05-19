module Jekyll
  class ImageBlock < Liquid::Tag
    def initialize(tag_name, data, tokens)
      super

      params = data.split(" ")
      raise 'ImageBlock must be used with "filename [width] [float]"' if params.size > 3
      @url, @width, @float = params
    end

    def render(context)
      url = unless @url =~ /^https?:\/\// then context.registers[:site].baseurl + '/assets/images/' + @url else @url end
      width_html = unless @width.nil? then "style='width: #{@width}'" else '' end
      image_html = "<img src=\"#{url}\" alt=\"Image could not be loaded\" #{width_html if @float.nil?}/>"
      "<div class=\"imagebox #{@float}\" #{width_html if @float}>#{image_html}</div>"
    end
  end

  class ImageBlock2 < Liquid::Block
    def initialize(tag_name, data, tokens)
      super

      params = data.split(" ")
      raise 'ImageBlock must be used with "filename [width] [float]"' if params.size > 3
      @url, @width, @float = params
    end

    def render(context)
      url = unless @url =~ /^https?:\/\// then context.registers[:site].baseurl + '/assets/images/' + @url else @url end
      caption = super.strip

      width_html = unless @width.nil? then "style='width: #{@width}'" else '' end
      image_html = "<img src=\"#{url}\" alt=\"Image could not be loaded\" #{width_html if @float.nil?}/>"
      caption_html = if caption != '' then "<label>#{caption}</label>" else '' end
      "<div class=\"imagebox #{@float}\" #{width_html if @float}>#{image_html + caption_html}</div>"
    end
  end
end

Liquid::Template.register_tag('image', Jekyll::ImageBlock)
Liquid::Template.register_tag('imagecaption', Jekyll::ImageBlock2)
