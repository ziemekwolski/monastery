class CopyTranslatedDataToMainTable < ActiveRecord::Migration
  def up
    Category.drop_translation_table! migrate_data: true if Category.respond_to?("drop_translation_table!")
    Post.drop_translation_table! migrate_data: true if Post.respond_to?("drop_translation_table!")
    Setting.drop_translation_table! migrate_data: true if Setting.respond_to?("drop_translation_table!")
    User.drop_translation_table! migrate_data: true if User.respond_to?("drop_translation_table!")
  end

  def down
    raise "No going back."
  end
end
