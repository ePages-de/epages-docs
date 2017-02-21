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
      "<a class=\"imagebox #{@float}\" #{width_html if @float} href=\"#{url}\" data-lightbox=\"imagebox\">#{image_html}</a>"
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
      "<a class=\"imagebox #{@float}\" #{width_html if @float} href=\"#{url}\" data-lightbox=\"imagebox\">#{image_html + caption_html}</a>"

    end
  end

  class ImageBlock3 < Liquid::Block
    def initialize(tag_name, data, tokens)
      super
      @url = data.strip
    end

    def render(context)
      url = unless @url =~ /^https?:\/\// then context.registers[:site].baseurl + '/assets/images/' + @url else @url end

      image_html = "<img src=\"#{url}\" style=\"height: 100% !important; width: 100% !important; max-width: inherit;\" alt=\"Image could not be loaded\"/>"
      "<a class=\"imagebox center\" href=\"#{url}\" data-lightbox=\"imagebox\">#{image_html}</a>"
    end
  end
end

Liquid::Template.register_tag('image', Jekyll::ImageBlock)
Liquid::Template.register_tag('imagecaption', Jekyll::ImageBlock2)
Liquid::Template.register_tag('imagebasic', Jekyll::ImageBlock3)
