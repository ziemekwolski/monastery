class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :slug, null: false
      t.string :title, null: false
      t.string :subtitle
      t.text   :body, null: false
      t.integer :user_id, null: false
      t.integer :category_id
      t.integer :upload_id
      t.boolean :is_static, null: false, default: false
      t.string :source_url
      t.string :source_name
      t.string :seo_title
      t.string :seo_description

      t.timestamps
    end
  end
end
