class AddSnippetToUsers < ActiveRecord::Migration
  def up
    add_column :users, :snippet, :text
    if User.respond_to?("create_translation_table!")
      User.create_translation_table!({
        snippet: :text
      }, {
        migrate_data: true
      })
    end
  end

  def down
    remove_column :users, :snippet
    User.drop_translation_table! migrate_data: true if User.respond_to?("drop_translation_table!")
  end
end
