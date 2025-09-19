require 'json'
require 'erb'
require 'fileutils'

begin
  require 'jekyll'
rescue LoadError
  # Jekyll not available, define minimal structure for standalone use
  module Jekyll
    class Generator
      def self.safe(*args); end
      def self.priority(*args); end
    end
  end
end

module Jekyll
  class PostmanPdfGenerator < Generator
    safe true
    priority :low

    def generate(site)
      postman_dir = File.join(site.source, 'postman_collections')
      return unless Dir.exist?(postman_dir)

      Dir.glob(File.join(postman_dir, '*.json')).each do |collection_file|
        collection_name = File.basename(collection_file, '.json')
        generate_pdf_for_collection(site, collection_file, collection_name)
      end
    end

    private

    def generate_pdf_for_collection(site, collection_file, collection_name)
      begin
        collection_data = JSON.parse(File.read(collection_file))
        
        # Generate HTML documentation
        html_content = generate_html_documentation(collection_data)
        
        # Create temporary HTML file
        temp_html_file = File.join(site.source, "_site", "#{collection_name}_temp.html")
        FileUtils.mkdir_p(File.dirname(temp_html_file))
        File.write(temp_html_file, html_content)
        
        # Generate PDF
        pdf_output_path = File.join(site.source, "_site", "#{collection_name}.pdf")
        wkhtmltopdf_command = [
          "wkhtmltopdf",
          "--page-size", "A4",
          "--orientation", "Portrait",
          "--margin-top", "0.75in",
          "--margin-right", "0.75in",
          "--margin-bottom", "0.75in",
          "--margin-left", "0.75in",
          "--encoding", "UTF-8",
          "--print-media-type",
          "--enable-local-file-access",
          temp_html_file,
          pdf_output_path
        ]
        
        system(*wkhtmltopdf_command)
        
        # Clean up temporary file
        File.delete(temp_html_file) if File.exist?(temp_html_file)
        
        puts "Generated PDF: #{pdf_output_path}"
        
      rescue JSON::ParserError => e
        puts "Error parsing JSON file #{collection_file}: #{e.message}"
      rescue => e
        puts "Error generating PDF for #{collection_name}: #{e.message}"
      end
    end

    def generate_html_documentation(collection_data)
      erb_template = ERB.new(html_template)
      erb_template.result(binding)
    end

    def html_template
      <<~HTML
        <!DOCTYPE html>
        <html lang="en">
        <head>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title><%= collection_data['info']['name'] %> - API Documentation</title>
          <style>
            body {
              font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
              line-height: 1.6;
              color: #333;
              max-width: 800px;
              margin: 0 auto;
              padding: 20px;
            }
            h1 {
              color: #2c3e50;
              border-bottom: 3px solid #3498db;
              padding-bottom: 10px;
              margin-bottom: 30px;
            }
            h2 {
              color: #34495e;
              margin-top: 40px;
              margin-bottom: 20px;
              border-bottom: 1px solid #bdc3c7;
              padding-bottom: 5px;
            }
            h3 {
              color: #2980b9;
              margin-top: 30px;
              margin-bottom: 15px;
            }
            .method-badge {
              display: inline-block;
              padding: 4px 8px;
              border-radius: 4px;
              color: white;
              font-weight: bold;
              font-size: 12px;
              margin-right: 10px;
            }
            .method-get { background-color: #27ae60; }
            .method-post { background-color: #e67e22; }
            .method-put { background-color: #8e44ad; }
            .method-delete { background-color: #e74c3c; }
            .method-patch { background-color: #f39c12; }
            .url {
              font-family: 'Courier New', monospace;
              background-color: #ecf0f1;
              padding: 5px 10px;
              border-radius: 4px;
              font-size: 14px;
            }
            .description {
              margin: 15px 0;
              color: #555;
            }
            .request-body, .response-body {
              background-color: #2c3e50;
              color: #ecf0f1;
              padding: 15px;
              border-radius: 5px;
              overflow-x: auto;
              font-family: 'Courier New', monospace;
              font-size: 12px;
              white-space: pre-wrap;
              margin: 10px 0;
            }
            .headers-table {
              width: 100%;
              border-collapse: collapse;
              margin: 15px 0;
            }
            .headers-table th,
            .headers-table td {
              border: 1px solid #bdc3c7;
              padding: 8px 12px;
              text-align: left;
            }
            .headers-table th {
              background-color: #3498db;
              color: white;
            }
            .request-section {
              margin: 25px 0;
              padding: 20px;
              border: 1px solid #bdc3c7;
              border-radius: 5px;
              background-color: #f8f9fa;
            }
            .toc {
              background-color: #ecf0f1;
              padding: 20px;
              border-radius: 5px;
              margin-bottom: 30px;
            }
            .toc ul {
              list-style-type: none;
              padding-left: 0;
            }
            .toc li {
              margin: 5px 0;
              padding-left: 20px;
            }
          </style>
        </head>
        <body>
          <h1><%= collection_data['info']['name'] %></h1>
          
          <div class="description">
            <% if collection_data['info']['description'] %>
              <p><%= collection_data['info']['description'] %></p>
            <% end %>
            <p><strong>Version:</strong> <%= collection_data['info']['version'] %></p>
            <p><strong>Schema:</strong> <%= collection_data['info']['schema'] %></p>
          </div>

          <div class="toc">
            <h2>Table of Contents</h2>
            <ul>
              <% collection_data['item'].each_with_index do |item, index| %>
                <li><a href="#request-<%= index %>"><%= item['name'] %></a></li>
              <% end %>
            </ul>
          </div>

          <% collection_data['item'].each_with_index do |item, index| %>
            <div class="request-section" id="request-<%= index %>">
              <h2><%= item['name'] %></h2>
              
              <% if item['description'] %>
                <div class="description"><%= item['description'] %></div>
              <% end %>

              <% if item['request'] %>
                <h3>Request</h3>
                
                <div>
                  <span class="method-badge method-<%= item['request']['method'].downcase %>">
                    <%= item['request']['method'] %>
                  </span>
                  <span class="url">
                    <%= format_url(item['request']['url']) %>
                  </span>
                </div>

                <% if item['request']['header'] && !item['request']['header'].empty? %>
                  <h4>Headers</h4>
                  <table class="headers-table">
                    <thead>
                      <tr>
                        <th>Key</th>
                        <th>Value</th>
                        <th>Description</th>
                      </tr>
                    </thead>
                    <tbody>
                      <% item['request']['header'].each do |header| %>
                        <tr>
                          <td><%= header['key'] %></td>
                          <td><%= header['value'] %></td>
                          <td><%= header['description'] || '' %></td>
                        </tr>
                      <% end %>
                    </tbody>
                  </table>
                <% end %>

                <% if item['request']['body'] && item['request']['body']['raw'] %>
                  <h4>Request Body</h4>
                  <div class="request-body"><%= format_json(item['request']['body']['raw']) %></div>
                <% end %>
              <% end %>

              <% if item['response'] && !item['response'].empty? %>
                <h3>Responses</h3>
                <% item['response'].each_with_index do |response, resp_index| %>
                  <h4>Response <%= resp_index + 1 %> - Status: <%= response['code'] %></h4>
                  
                  <% if response['header'] && !response['header'].empty? %>
                    <h5>Response Headers</h5>
                    <table class="headers-table">
                      <thead>
                        <tr>
                          <th>Key</th>
                          <th>Value</th>
                        </tr>
                      </thead>
                      <tbody>
                        <% response['header'].each do |header| %>
                          <tr>
                            <td><%= header['key'] %></td>
                            <td><%= header['value'] %></td>
                          </tr>
                        <% end %>
                      </tbody>
                    </table>
                  <% end %>

                  <% if response['body'] %>
                    <h5>Response Body</h5>
                    <div class="response-body"><%= format_json(response['body']) %></div>
                  <% end %>
                <% end %>
              <% end %>
            </div>
          <% end %>
        </body>
        </html>
      HTML
    end

    def format_url(url_obj)
      if url_obj.is_a?(String)
        return url_obj
      elsif url_obj.is_a?(Hash)
        protocol = url_obj['protocol'] || 'https'
        host = url_obj['host']
        if host.is_a?(Array)
          host = host.join('.')
        elsif host.is_a?(String) && host.include?('{{')
          host = host
        end
        path = url_obj['path']
        if path.is_a?(Array)
          path = '/' + path.join('/')
        elsif path.is_a?(String)
          path = path.start_with?('/') ? path : '/' + path
        end
        return "#{protocol}://#{host}#{path}"
      end
      return url_obj.to_s
    end

    def format_json(json_string)
      return '' if json_string.nil? || json_string.empty?
      
      begin
        parsed = JSON.parse(json_string)
        JSON.pretty_generate(parsed)
      rescue JSON::ParserError
        json_string
      end
    end
  end
end