class CreateRedirects < ActiveRecord::Migration
  def change
    create_table :redirects do |t|
      t.string :from_slug, null: false
      t.string :to_path
      t.integer :redirectable_id
      t.string  :redirectable_type
      t.timestamps
    end
  end
end
