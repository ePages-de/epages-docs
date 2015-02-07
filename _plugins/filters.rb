module Jekyll
  module CustomFilters
    def chunked_array(array, chunk_size)
      array.each_slice(chunk_size).to_a
    end
  end
end

Liquid::Template.register_filter(Jekyll::CustomFilters)
