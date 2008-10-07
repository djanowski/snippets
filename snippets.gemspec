Gem::Specification.new do |s|
  s.name = 'snippets'
  s.version = '0.1'
  s.summary = %{Include snippets of content in your Rails views and let the client modify them.}
  s.description = %{}
  s.date = %q{2008-10-06}
  s.author = "Damian Janowski"
  s.email = "damian.janowski@gmail.com"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.files = ["lib/snippet.rb", "lib/snippets/helper.rb", "lib/snippets/parsers/html.rb", "lib/snippets/parsers/textile.rb", "lib/snippets/parsers.rb", "lib/snippets.rb", "rails/init.rb", "README.textile", "MIT-LICENSE", "Rakefile"]

  s.require_paths = ["lib", "lib/snippets"]

  s.extra_rdoc_files = ["README.textile"]
  s.has_rdoc = true
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "tti", "--main", "README.textile"]
end
