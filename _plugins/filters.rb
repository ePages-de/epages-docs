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
  end
end

Liquid::Template.register_filter(Jekyll::CustomFilters)
