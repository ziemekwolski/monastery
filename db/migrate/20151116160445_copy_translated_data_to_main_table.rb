class CopyTranslatedDataToMainTable < ActiveRecord::Migration
  def up
    Category.drop_translation_table! migrate_data: true
    Post.drop_translation_table! migrate_data: true
    Setting.drop_translation_table! migrate_data: true
    User.drop_translation_table! migrate_data: true
  end

  def down
    raise "No going back."
  end
end
