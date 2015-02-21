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
          resolved = ::Sitemap.resolve(site, node['href'])
          node['href'] = resolved unless resolved.nil?
        end
      end
    end

    Loofah.fragment(input).
      scrub!(parse_special_links).
      to_s
  end

  def site
    # FIXME this is a really hacky solution
    Jekyll.sites.first
  end
end
