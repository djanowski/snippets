# ['snippets', 'snippets/parsers'].each do |dir|
#   $:.unshift(File.join(File.dirname(__FILE__), dir))
# end

require 'snippet'
require 'snippets/parsers/html'
require 'snippets/parsers/plain_text'
require 'snippets/parsers/textile'

module Snippets
end
