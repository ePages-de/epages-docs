# encoding: utf-8
require 'html/proofer'

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
        errors += check_trailing_whitespaces(file)
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
  class UnresolvedReferencesLinkCheck < HTML::Proofer::Checkable
    attr_reader :href

    def unresolved_reference?
      if @href =~ /([a-z0-9\-]+):([a-z0-9\-]+)(#(.+))?/
        case $1
          when 'mailto'
            false
          else
            return 'true'
        end
      end
    end
  end

  class UnresolvedReferences < HTML::Proofer::CheckRunner
    def run
      @html.css('a').each do |l|
        link = UnresolvedReferencesLinkCheck.new l, self

        if link.unresolved_reference?
          return add_issue("There is an unresolvable reference to #{link.href}")
        end
      end
    end
  end

  sh "bundle exec jekyll build"
  HTML::Proofer.new("./_site", :disable_external => true, :href_ignore => ["#"]).run
end

task :ramlup do
  require 'net/http'
  require 'rexml/document'
  require 'zip'
  require 'fileutils'

  def download(url)
    response = Net::HTTP.get_response(URI.parse(url))
    if response.code == '200'
      response.body
    else
      raise
    end
  end

  def get_latest_raml_version
    url = 'http://ep-artifacts:8081/artifactory/epages-release-local/com/epages/epagesj/maven-metadata.xml'
    metadata = REXML::Document.new(download(url))
    metadata.elements['metadata'].elements['versioning'].elements['latest'].text
  end

  def get_raml_archive(version)
    url = "http://ep-artifacts:8081/artifactory/epages-release-local/com/epages/epagesj/#{version}/epagesj-#{version}-raml.zip"
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

  target = '_raml/apps/'
  latest_version = get_latest_raml_version
  puts "Latest RAML archive version is #{latest_version}"
  puts "Downloading archive"
  raml_archive = get_raml_archive(latest_version)
  puts "Clearing directory #{target}"
  delete_directory_content(target)
  puts "Unpacking RAML files"
  Zip::InputStream.open(StringIO.new(raml_archive)) { |zip| unpack_zip_archive(zip, 'raml/', target) }
end

task :index do
  sh "bundle exec jekyll index"
end

task :build do
  sh "bundle exec jekyll build -t"
end

task :default do
  sh "bundle exec jekyll serve --host 0.0.0.0 --watch"
end
