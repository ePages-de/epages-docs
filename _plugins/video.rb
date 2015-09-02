module JekyllVideoTag
  class Video < Liquid::Tag
    def initialize(tag_name, input, _)
      super
      input = input.split(' ')
      @name = input[0]
      @width, @height = input[1].nil? ? ["560", "420"] : [input[1], input[2]]
    end

    def render(context)
      '<div class="video-container" style="text-align: center">
        <video width="' + @width + '" height="' + @height + '" controls>
          <source src="' + context.registers[:site].baseurl + '/videos/' + @name + '.mp4" type="video/mp4">
        </video>
      </div>'
    end
  end

  class Youtube < Liquid::Tag
    VIDEO_CODE_RE = /^\s*([^\s]+)(\s+(\d+)\s+(\d+)\s*)?/

    def initialize(tagName, markup, _)
      super
      if markup =~ VIDEO_CODE_RE
        @video = $1
        @width, @height = $2.nil? ? ["560", "420"] : [$3, $4]
      else
        raise "No YouTube ID provided in the \"youtube\" tag"
      end
    end

    def render(context)
      '<div class="video-container" style="text-align: center">
        <iframe width="' + @width + '" height="' + @height + '"
          src="http://www.youtube.com/embed/' + @video +'" frameborder="0" allowfullscreen></iframe>
       </div>'
    end
  end
end

Liquid::Template.register_tag('video', JekyllVideoTag::Video)
Liquid::Template.register_tag('youtube', JekyllVideoTag::Youtube)
