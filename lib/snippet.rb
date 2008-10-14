class Snippet < ActiveRecord::Base
  validates_uniqueness_of :slug
  validates_presence_of :slug

  before_save :compile_text

  class << self
    def get(slug, options = {})
      snippet = find_by_slug(slug.to_s.downcase) || create!(options.merge(:slug => slug))
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
    compiled_text.to_s
  end

  def %(*args)
    if args.size == 1 && args.first.kind_of?(Hash)
      text = to_s

      args.first.each do |key,value|
        text = text.gsub("{{#{key}}}", value)
      end

      text
    else
      sprintf(to_s, *args)
    end
  end

  def empty?
    to_s.empty?
  end

  def blank?
    to_s.blank?
  end

  def inspect
    to_s.inspect
  end

  def ==(other)
    to_s.eql?(other)
  end

  private

    def compile_text
      self.parser = Snippet.default_parser if parser.blank?
      self.compiled_text = Snippet.parse(text, parser)
    end

end
