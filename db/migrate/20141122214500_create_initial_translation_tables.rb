class CreateInitialTranslationTables < ActiveRecord::Migration
  def up
    if Post.respond_to?("create_translation_table!")
      Post.create_translation_table!({
        title: :string,
        subtitle: :string,
        summary: :text,
        body: :text,
        seo_description: :text,
        seo_tags: :string
      }, {
        migrate_data: true
      })
    end

    if Setting.respond_to?("create_translation_table!")
      Setting.create_translation_table!({
        value: :text
      }, {
        migrate_data: true
      })
    end

    if Category.respond_to?("create_translation_table!")
      Category.create_translation_table!({
        name: :string,
        description: :text
      }, {
        migrate_data: true
      })
    end
  end

  def down
    Post.drop_translation_table! migrate_data: true if Post.respond_to?("drop_translation_table!")
    Setting.drop_translation_table! migrate_data: true if Setting.respond_to?("drop_translation_table!")
    Category.drop_translation_table! migrate_data: true if Category.respond_to?("drop_translation_table!")
  end
end
