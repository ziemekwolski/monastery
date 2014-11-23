class CreateInitialTranslationTables < ActiveRecord::Migration
  def up
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

    Setting.create_translation_table!({
      value: :text
    }, {
      migrate_data: true
    })

    Category.create_translation_table!({
      name: :string,
      description: :text
    }, {
      migrate_data: true
    })
  end

  def down
    Post.drop_translation_table! migrate_data: true
    Setting.drop_translation_table! migrate_data: true
    Category.drop_translation_table! migrate_data: true
  end
end
