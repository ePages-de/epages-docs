require 'emoji'

module Jekyll
  class EmojiTag < Liquid::Tag
    def initialize(tag_name, input, _)
      super
      @emoji_alias = input.strip!
      @emoji = Emoji.find_by_alias(@emoji_alias)
    end

    def render(context)
      @emoji ? "<img alt=\":#{@emoji_alias}:\" src=\"/assets/images/emoji/#{@emoji.image_filename}\" style=\"vertical-align:sub\" width=\"20\" height=\"20\"/>" : ":#{@emoji_alias}:"
    end
  end
end

Liquid::Template.register_tag('emoji', Jekyll::EmojiTag)
