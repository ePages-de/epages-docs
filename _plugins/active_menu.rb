module Jekyll
  class ActiveMenu < Liquid::Tag
    def initialize(tag_name, data, tokens)
      super
      @data = data.strip
    end

    def render(context)
      name = context.environments.first['page']['url'].split('/')[1].to_s
      return '' if name.nil? or @data.nil?
      return name.include?(@data) ? 'navigation__link--active' : ''
    end
  end
end

Liquid::Template.register_tag('active_menu', Jekyll::ActiveMenu)
