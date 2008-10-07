module Snippets
  module Helper
    def snippet(slug, options = {}, &block)
      text = capture(&block) if block_given?
      Snippet.get(slug, {:text => text}.merge(options))
    end
  end
end
