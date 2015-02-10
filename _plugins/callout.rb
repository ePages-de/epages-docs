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
      site = context.registers[:site]
      converter = site.getConverterImpl(Jekyll::Converters::Markdown)
      content = "**#{@title}** #{super.to_s.strip}"

      "<div class=\"alert alert-#{@mode}\" role=\"alert\">#{converter.convert(content)}</div>"
    end
  end
end

Liquid::Template.register_tag('callout', Jekyll::CalloutBlock)
