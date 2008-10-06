module Snippets
  module Helper
    def snippet(slug, &block)
      text = capture(&block) if block_given?
      Snippet.get(slug, :text => text)
    end
  end
end
