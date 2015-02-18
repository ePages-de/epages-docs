class Jekyll::Converters::Markdown::ExtendedMarkdown
  def initialize(config)
    @kramdown = Jekyll::Converters::Markdown::KramdownParser.new(config)
  end

  def convert(content)
    transform(@kramdown.convert(content))
  end

  def transform(input)
    require 'loofah'

    parse_special_links = Loofah::Scrubber.new do |node|
      if node.name == 'a'
        if node['href'].strip =~ /([a-z\-]+):([a-z\-]+)(#([a-z\-]+))?/
          transformed = transform_link($1, $2, $4)
          node['href'] = transformed unless transformed.nil?
        end
      end
    end

    Loofah.fragment(input).
      scrub!(parse_special_links).
      to_s
  end

  def transform_link(type, key, anchor)
    case type
      when 'page'
        page = site.pages.detect { |page| page.data['key'] == key }
        if not page.nil?
          part_url = site.baseurl + page.url
          part_anchor = if not anchor.nil? and anchor.strip then '#' + anchor.strip else '' end

          "#{part_url}#{part_anchor}"
        else
          puts "Could not find page with key '#{key}'"
          nil
        end
      else
        nil
    end
  end

  def site
    # FIXME this is a really hacky solution
    Jekyll.sites.first
  end
end
