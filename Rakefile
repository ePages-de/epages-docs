# encoding: utf-8
require 'yaml'
require 'fileutils'

class String
  # colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def blue
    colorize(34)
  end
end

task :test do
  class LinterLine
    attr_reader :file, :raw, :line_num, :content

    def initialize(file, raw, line_num)
      @file = file
      @raw = raw
      @line_num = line_num
      @content = raw.chomp
    end
  end

  class LinterError
    attr_reader :file, :line, :message

    def initialize(file, line, message)
      @file = file
      @line = line
      @message = message
    end
  end

  class Linter
    def initialize(dir, glob, ignore = [])
      @dir = dir
      @glob = glob
      @ignore = ignore
    end

    def run
      puts "Running linter checks on #{@dir} on #{@glob}".blue

      files = find_files
      errors = []
      files.each do |file|
        errors += check_line_endings(file)
        if !(File.basename(file).end_with?(".md"))
          errors += check_trailing_whitespaces(file)
        end
        errors += check_indentation(file)
        errors += check_filename(file)
      end

      errors.each do |error|
        if error.line
          puts "#{error.file}:#{error.line.line_num} #{error.message}".red
        else
          puts "#{error.file} #{error.message}".red
        end
      end
      abort if errors.length > 0
    end

    def check_line_endings(file)
      errors = []
      if ['.html', '.scss', '.js', '.yml', '.md'].include? File.extname(file)
        lines = read_file_lines(file)
        lines.each do |line|
          if line.raw.end_with? "\r\n"
            errors << LinterError.new(file, line, 'Found windows line ending (CRLF)')
          end

          if line.raw.end_with? "\r"
            errors << LinterError.new(file, line, 'Found old Macintosh line ending (LF)')
          end
        end
      end
      errors
    end

    def check_trailing_whitespaces(file)
      errors = []
      if ['.html', '.scss', '.js', '.yml', '.md'].include? File.extname(file)
        lines = read_file_lines(file)
        lines.each do |line|
          if line.content =~ /\s+$/
            errors << LinterError.new(file, line, 'Found trailing whitespaces')
          end
        end
      end
      errors
    end

    def check_indentation(file)
      errors = []
      if ['.html', '.scss', '.js', '.yml', '.md', '.rb'].include? File.extname(file)
        lines = read_file_lines(file)
        lines.each do |line|
          if line.content =~ /^\s*\t+\s*/
            errors << LinterError.new(file, line, 'Contains tabs in indentation')
          end
        end
      end
      errors
    end

    def check_filename(file)
      errors = []
      unless file =~ /^[a-z0-9\-\_\.\/]+$/
        errors << LinterError.new(file, nil, 'Filenames must only contain lower case letters, numbers, dashes, underscores or points')
      end
      errors
    end

    def find_files
      Dir.glob(File.join(@dir, @glob))
          .select { |file| not @ignore.any? { |ign| file.start_with? ign } }
          .select { |file| File.file?(file) }
    end

    def read_file_lines(file)
      File.foreach(file).with_index.map { |raw, line_num| LinterLine.new(file, raw, line_num + 1) }
    end
  end

  Linter.new('.', '*/**/*.*', ['./.git', './.sass_cache', './_site/', './_sass/bootstrap/', './_sass/font-awesome/', './assets/fonts', './vendor/', './README.md']).run
end

task :test do
  require 'html-proofer'

  sh "bundle exec jekyll build"
  HTMLProofer.check_directory("./_site", :disable_external => true, :assume_extension => true, :href_ignore => ["#"]).run
end

task :ramlup do
  require 'net/http'
  require 'rexml/document'
  require 'zip'
  require 'fileutils'

  RAML_VERSIONS = 'http://ep-artifacts:8081/artifactory/epages-snapshot-local/com/epages/epagesj/maven-metadata.xml'
  TARGET = '_raml/apps/'
  TMP = 'tmp/'

  def download(url)
    response = Net::HTTP.get_response(URI.parse(url))
    if response.code == '200'
      response.body
    else
      raise
    end
  end

  def last_raml_version
    metadata = REXML::Document.new(download(RAML_VERSIONS))
    metadata.elements['metadata'].elements['versioning'].elements['latest'].text
  end

  def get_raml_archive(version)
    url = "http://ep-artifacts:8081/artifactory/epages-snapshot-local/com/epages/epagesj/#{version}/epagesj-#{version}-raml.zip"
    download(url)
  end

  def delete_directory_content(dir)
    Dir.foreach(dir) do |e|
      unless %w(. ..).include? e
        fullname = dir + File::Separator + e
        if FileTest::directory?(fullname)
          delete_directory_content(fullname)
          Dir.delete(fullname)
        else
          File.delete(fullname)
        end
      end
    end
  end

  def copying_files(version)
    puts "Downloading version: #{version}"
    raml_files = get_raml_archive(version)
    Dir.mkdir("#{TMP}/#{version}")
    Zip::InputStream.open(StringIO.new(raml_files)) { |zip| unpack_zip_archive(zip, 'raml/', "#{TMP}/#{version}/") }
  end

  def unpack_zip_archive(zip, source, target)
    while (entry = zip.get_next_entry)
      if entry.name =~ Regexp.new("^#{source}(.+)$")
        if entry.name.end_with? '/'
          Dir.mkdir(target + $1)
          zip.read
        else
          File.write(target + $1, zip.read)
        end
      end
    end
  end

  current_version = File.open("#{TMP}/doc_version.txt", &:gets)
  last_version = last_raml_version
  unless current_version == last_version
    delete_directory_content(TMP)
    copying_files(current_version)
    copying_files(last_version)
    File.write("#{TMP}/doc_version.txt", last_version)
    system("opendiff #{TMP + current_version} #{TMP + last_version}")
  end
end

task :resource do
  SITEMAP_FILE = '_data/sitemap-apps.yml'
  MISC_FILE    = '_raml/apps/miscellaneous.raml'
  RESOURCE_DIR = 'apps/api-reference/'

  require 'active_support/inflector'

  def new_resource(resources)
    resources.each do |res|
      update_sitemap(res)
      create_resource(res)
    end
  end

  def new_miscellaneous(new_misc)
    old_misc = File.exist?(MISC_FILE) ? File.readlines(MISC_FILE).map { |r| r.gsub("\n","") } : []
    misc = (old_misc + new_misc).uniq.sort
    File.open(MISC_FILE, 'w').puts(misc.join("\n"))
    miscellaneous_template(misc.join(' '))
    p "Miscellaneous resources updated with: #{new_misc.join(', ')}."
  end

  def update_sitemap(new_resource)
    sitemap = YAML.load_file(SITEMAP_FILE)
    node = { 'title' => new_resource.capitalize.pluralize, 'link' => "page:api-resources-#{new_resource.pluralize}" }
    content = add_node_to_sitemap(sitemap, node)
    File.open(SITEMAP_FILE, 'w') { |document| document.write content }
    p "Sitemap-apps updated with #{new_resource} entry."
  end

  def create_resource(resource)
    raise "The route #{RESOURCE_DIR} not exists" unless File.dirname(RESOURCE_DIR)
    resource_template(resource)
    p "Created new layout for #{resource}"
  end

  def add_node_to_sitemap(sitemap, node)
    sitemap.map do |section|
      if section.has_value?("api-rest")
        break if section["entries"].any?{ |e| e['title'] == node['title'] }
        section["entries"] << node
        section["entries"] = section["entries"].sort_by(&:first)
      end
    end
    yaml_formatter(sitemap)
  end

  def yaml_formatter(file)
    #format the interspace between entries
    content = file.to_yaml
    content.gsub("---\n", "")
        .gsub(/- title:.*/){ |s| '  ' + s }
        .gsub(/link:.*/)   { |s| '  ' + s + "\n" }
  end

  def resource_template(resource)
    template = """---
layout: page
key: api-resources-#{resource.pluralize}
title: #{resource.capitalize.pluralize}
---
<ul id=\"resource-list\">
  {% for page in site.pages %}
    {% assign match = page.key | regex_match: '^apps-api-([a-z]+)-shops-shopid-#{resource.pluralize}(.*)-information$' %}
    {% if match %}
      <li class=\"resource-entry\">
        <span class=\"http-method http-method-{{ page.raml_method.method | downcase }}\">{{ page.raml_method.method }}</span>
        <a href=\"{{ page.url | prepend: site.baseurl }}\"#content>{{ page.raml_resource.relative_uri }}#</a>
        {% if page.raml_method.description contains '*epages6' %}
          <span class='ep-label-6 ep-label'>ePages 6</span>
        {% endif %}
        {% if page.raml_method.description contains '*epagesNow' %}
          <span class='ep-label-now ep-label'>ePages Now</span>
        {% endif %}
      </li>
    {% endif %}
  {% endfor %}
</ul>"""

    file_name = RESOURCE_DIR + "resource-" + resource + ".md"
    File.new(file_name, 'w').puts(template)
  end

  def miscellaneous_template(miscellaneous)
    template = """---
layout: page
key: api-resources-miscellaneous
title: Miscellaneous
---
<ul id=\"resource-list\">
  {% for page in site.pages %}
  {% assign misc = \"#{miscellaneous}\" | split: ' ' %}
    {% for category in misc %}
      {% if page.raml_resource.relative_uri contains category %}
        <li class=\"resource-entry\">
          <span class=\"http-method http-method-{{ page.raml_method.method | downcase }}\">{{ page.raml_method.method }}</span>
          <a href=\"{{ page.url | prepend: site.baseurl }}\"#content>{{ page.raml_resource.relative_uri }}</a>
          {% if page.raml_method.description contains '*epages6' %}
            <span class='ep-label-6 ep-label'>ePages 6</span>
          {% endif %}
          {% if page.raml_method.description contains '*epagesNow' %}
            <span class='ep-label-now ep-label'>ePages Now</span>
          {% endif %}
        </li>
      {% endif %}
    {% endfor %}
  {% endfor %}
</ul>"""

    file_name = RESOURCE_DIR + "resource-miscellaneous.md"
    File.new(file_name, 'w').puts(template)
  end

  if !ENV['new'] && !ENV['misc']
    raise ArgumentError, "No parameters"
  end

  new_resource(ENV['new'].split(",")) if ENV['new']
  new_miscellaneous(ENV['misc'].split(",")) if ENV['misc']
end

task :archive do
  API_REFERENCES = '_raml'
  API_DOC        = 'apps'
  API_VERSIONS   = '_data/api-versions.yml'
  VERSION        = "v-#{ENV['version']}"

  references_dest = "#{API_REFERENCES}/#{VERSION}"
  doc_dest = "#{API_DOC}/#{VERSION}"

  def copy_resources(src, dest)
    sh "rsync -a --exclude 'v-*' #{src}/ #{dest}"
  end

  def change_file_keys(paths)
    files = Dir["#{paths}/**/*.md"]
    files.each do |file_name|
      text = File.read(file_name)
      new_contents = text.gsub(/key: (.*)/, "key: \\1-#{VERSION}")
      File.open(file_name, "w") {|file| file.puts new_contents }
    end
  end

  def update_versions
    content = YAML.load_file(API_VERSIONS)
    content['versions'].nil? ?
      content['versions'] = [{'title' => ENV['version']}] :
      content['versions'] << {'title' => ENV['version']}
    File.write(API_VERSIONS, YAML.dump(content))
  end

  raise ArgumentError, "Version not passed as parameter \n Usage:\n > rake release version=my_version" unless ENV['version']

  update_versions

  copy_resources(API_REFERENCES, references_dest)

  copy_resources(API_DOC, doc_dest)
  change_file_keys(doc_dest)
end

task :build do
  sh "bundle exec jekyll build -t -q --config '_config.yml'"
end

task :serve do
  sh "bundle exec jekyll serve --host 0.0.0.0 --watch --config '_config.yml'"
end

task :dev do
  sh "bundle exec jekyll serve --host 0.0.0.0 --watch --incremental --config '_dev_config.yml'"
end

task :fast_dev do
  sh "bundle exec jekyll serve --host 0.0.0.0 --watch --incremental --skip-initial-build --config '_dev_config.yml'"
end

task :default do
  Rake::Task["build"].invoke
  Rake::Task["serve"].invoke
end
