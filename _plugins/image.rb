module Jekyll
  class ImageBlock < Liquid::Tag
    def initialize(tag_name, data, tokens)
      super

      params = data.split(" ")
      raise 'ImageBlock must be used with "filename [width] [float]"' if params.size > 3
      @url, @width, @float = params
    end

    def render(context)
      url = unless @url =~ /^https?:\/\// then context.registers[:site].baseurl + '/assets/images/apps/' + @url else @url end
      width_html = unless @width.nil? then "style='width: #{@width}'" else '' end
      image_html = "<img src='#{url}' alt='#{@url}' #{width_html if @float.nil?}/>"
      "<a class='imagebox #{@float}' #{width_html if @float} href='#{url}' data-lightbox='imagebox'>#{image_html}</a>"
    end
  end
end

Liquid::Template.register_tag('image', Jekyll::ImageBlock)
