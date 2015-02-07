module Jekyll
  class CalloutBlock < Liquid::Block
    def initialize(tag_name, data, tokens)
      super

      if data.strip =~ /^(success|info|warning|danger) (.*)$/
        @mode = $1
        @title = $2
      else
        raise 'CalloutBlock must be used with "success|info|warning|danger title"'
      end
    end

    def render(context)
      content = super.to_s.strip
      if @title != ''
        "<div class=\"alert alert-#{@mode}\" role=\"alert\"><strong>#{@title}</strong> #{content}</div>"
      else
        "<div class=\"alert alert-#{@mode}\" role=\"alert\">#{content}</div>"
      end
    end
  end
end

Liquid::Template.register_tag('callout', Jekyll::CalloutBlock)
