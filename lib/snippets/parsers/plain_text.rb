require 'erb'

module Snippets
  module Parsers
    class PlainText
      def self.parse(text)
        ERB::Util.h(text)
      end
    end
  end
end
