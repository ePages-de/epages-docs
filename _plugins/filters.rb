require 'liquid'
require 'uri'

module Jekyll
  module CustomFilters
    def chunked_array(array, chunk_size)
      array.each_slice(chunk_size).to_a
    end

    def jsonify_pretty(input)
      require 'json'
      JSON.pretty_generate(input)
    end

    def start_with(input, start)
      input.start_with? start
    end

    def default(input, default_value = "".freeze)
      is_blank = input.respond_to?(:empty?) ? input.empty? : !input
      is_blank ? default_value : input
    end

    def contains(input, value)
      return false if input.nil? || value.nil?
      input.include? value
    end

    # Percent encoding for URI conforming to RFC 3986.
    # Ref: http://tools.ietf.org/html/rfc3986#page-12
    def url_encode(url)
      return URI.escape(url, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    end

    def regex_match(input, pattern)
      input =~ Regexp.new(pattern)
    end

    def regex_extract(input, pattern)
      if input =~ Regexp.new(pattern)
        $1
      else
        nil
      end
    end

    def regex_replace(input, pattern, substitution)
      input.gsub(Regexp.new(pattern), substitution)
    end

    def delete_epages_version(input)
      input.gsub(Regexp.new(/\*epages\S*/), '')
    end

    def to_xml_feed(input)
      return if input.start_with?('<p>')

      url = @context.registers[:site].config['url']
      date, title = input.to_s.gsub(/<.*?>/, '').split(/\n/).delete_if(&:empty?)
      date = DateTime.civil(*(date.split('-').map(&:to_i) + [9])).rfc822
      content = input[input.index('<ul>').. -1].gsub(/\r?\n/, '').gsub('href="/',"href=\"#{url}/")
      id = title.downcase.gsub(' ', '-').gsub('.', '')
      "<item><title>#{title}</title><link>#{url}/apps/change-log.html</link><pubDate>#{date}</pubDate><guid isPermaLink=\"true\">#{url}/apps/change-log.html##{id}</guid><description><![CDATA[#{content}]]></description></item>"
    end

    def versioning_visible(global_key, resource_url)
      return false if resource_url.nil? || global_key.nil?
      if /v-(\d|\.)*/.match(global_key).nil?
        return /v-(\d|\.)*/.match(resource_url).nil?
      else
        version = /v-(\d|\.)*/.match(global_key)[0]
        return resource_url.scan("#{version}").count == 1
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::CustomFilters)
