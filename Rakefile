require 'html/proofer'

task :test do
  class UnresolvedReferencesLinkCheck < HTML::Proofer::Checkable
    attr_reader :href

    def unresolved_reference?
      if @href =~ /([a-z\-]+):([a-z\-]+)(#([a-z\-]+))?/
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
