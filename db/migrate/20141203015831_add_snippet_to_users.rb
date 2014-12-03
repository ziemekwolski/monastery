class AddSnippetToUsers < ActiveRecord::Migration
  def up
    add_column :users, :snippet, :text
    User.create_translation_table!({
      snippet: :text
    }, {
      migrate_data: true
    })
  end

  def down
    remove_column :users, :snippet
    User.drop_translation_table! migrate_data: true
  end
end
