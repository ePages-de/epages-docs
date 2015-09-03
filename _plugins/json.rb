require 'json'

module Jekyll
  module JsonFilter
    # return the key names (one level deep) inside the property attribute
    def json_keys(input, property)
      JSON.parse(input)[property].keys unless input.nil?
    end

    #return the value of property attribute related to input
    def json_field(input, property)
      JSON.parse(input)[property] unless input.nil?
    end
  end
end
Liquid::Template.register_filter(Jekyll::JsonFilter)
