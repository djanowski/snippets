require 'rubygems'

gem 'rspec'
gem 'activerecord'
gem 'ruby-debug'

require 'spec'
require 'active_record'
require 'ruby-debug'

Dependencies.load_paths << File.expand_path(File.dirname(__FILE__) + '/../lib')
puts Dependencies.load_paths

ActiveRecord::Base.establish_connection :adapter => "sqlite3", :dbfile => ":memory:"

ActiveRecord::Schema.define do
  create_table :snippets do |t|
    t.string :slug
    t.string :text
    t.string :compiled_text
    t.string :parser
    t.timestamps
  end

  add_index :snippets, :slug
end

ActiveRecord::Base.logger = RAILS_DEFAULT_LOGGER = Logger.new($stderr)
# ActiveRecord::Base.colorize_logging = false

def create(attrs = {})
  Snippet.create!({:text => 'Lorem ipsum'}.merge(attrs))
end
