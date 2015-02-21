require 'html/proofer'

task :test do
  class UnresolvedReferencesLinkCheck < HTML::Proofer::Checkable
    attr_reader :href

    def unresolved_page?
      return @href.match /^page\:/
    end
  end

  class UnresolvedReferences < HTML::Proofer::CheckRunner
    def run
      @html.css('a').each do |l|
        link = UnresolvedReferencesLinkCheck.new l, self

        if link.unresolved_page?
          return add_issue("There is an unresolvable link to #{link.href}")
        end
      end
    end
  end

  sh "rm -rf ./_site"
  sh "bundle exec jekyll build -d ./_site/epages-docs"
  HTML::Proofer.new("./_site", :disable_external => true).run
end
