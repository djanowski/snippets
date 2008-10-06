require 'erb'

module Snippets
  module Parsers
    class Html
      def self.parse(text)
        ERB::Util.h(text)
      end
    end
  end
end
