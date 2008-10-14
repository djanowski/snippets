unless defined?(RedCloth)
  gem 'RedCloth'
  require 'RedCloth'
end

module Snippets
  module Parsers
    class Textile
      def self.parse(text)
        textilized = RedCloth.new(text, [ :hard_breaks ])
        textilized.hard_breaks = true if textilized.respond_to?("hard_breaks=")
        textilized.to_html
      end
    end
  end
end
