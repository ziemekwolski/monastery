class AddSeoTagsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :seo_tags, :string
  end
end
