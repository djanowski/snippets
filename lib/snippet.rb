class Snippet < ActiveRecord::Base
  validates_uniqueness_of :slug
  validates_presence_of :slug

  before_save :compile_text

  class << self
    def get(slug, options = {})
      snippet = find_by_slug(slug.to_s.downcase) || create!(options.merge(:slug => slug))
      snippet.compiled_text.to_s if snippet
    end

    def parse(text, parser = nil)
      parser = Snippet.default_parser if parser.blank?
      klass = Snippets::Parsers.const_get(parser.to_s.classify)
      klass.parse(text)
    end

    def default_parser
      'html'
    end
  end

  def to_s
    slug
  end

  private

    def compile_text
      self.parser = Snippet.default_parser if parser.blank?
      self.compiled_text = Snippet.parse(text, parser)
    end

end
