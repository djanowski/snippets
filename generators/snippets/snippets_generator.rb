class SnippetsGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.migration_template 'migration.rb', 'db/migrate', :migration_file_name => "create_snippets"
    end
  end

  protected
    def banner
      "Usage: #{$0} snippets"
    end
end
