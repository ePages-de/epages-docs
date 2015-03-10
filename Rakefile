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
        lines = read_file_lines(file)
        errors += check_line_endings(file, lines)
        errors += check_trailing_whitespaces(file, lines)
        errors += check_indentation(file, lines)
      end

      errors.each do |error|
        puts "#{error.file}:#{error.line.line_num} #{error.message}".red
      end
      abort if errors.length > 0
    end

    def check_line_endings(file, lines)
      errors = []
      lines.each do |line|
        if line.raw.end_with? "\r\n"
          errors << LinterError.new(file, line, 'Found windows line ending (CRLF)')
        end

        if line.raw.end_with? "\r"
          errors << LinterError.new(file, line, 'Found old Macintosh line ending (LF)')
        end
      end
      errors
    end

    def check_trailing_whitespaces(file, lines)
      errors = []
      lines.each do |line|
        if line.content =~ /\s+$/
          errors << LinterError.new(file, line, 'Found trailing whitespaces')
        end
      end
      errors
    end

    def check_indentation(file, lines)
      errors = []
      lines.each do |line|
        if line.content =~ /^\s*\t+\s*/
          errors << LinterError.new(file, line, 'Contains tabs in indentation')
        end
      end
      errors
    end

    def find_files
      Dir.glob(File.join(@dir, @glob)).select { |file| not @ignore.any? { |ign| file.start_with? ign } }
    end

    def read_file_lines(file)
      File.foreach(file).with_index.map { |raw, line_num| LinterLine.new(file, raw, line_num + 1) }
    end
  end

  Linter.new('.', '**/*.{html,scss,js,yml}', ['./.', './_site/', './_sass/bootstrap/']).run
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
  HTML::Proofer.new("./_site", :disable_external => true).run
end

task :default do
  sh "bundle exec jekyll serve --watch"
end
