['snippets', 'snippets/parsers'].each do |dir|
  $:.unshift(File.join(File.dirname(__FILE__), dir))
end

module Snippets
end
