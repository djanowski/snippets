class CreateSnippets < ActiveRecord::Migration
  def self.up
    create_table :snippets, :force => true do |t|
      t.string  :slug
      t.text    :text
      t.text    :compiled_text
      t.string  :parser
      t.string  :notes

      t.timestamps
    end

    add_index :snippets, :slug
  end

  def self.down
    remove_index :snippets, :slug

    drop_table :snippets
  end
end
