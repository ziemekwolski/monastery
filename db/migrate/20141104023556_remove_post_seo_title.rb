class RemovePostSeoTitle < ActiveRecord::Migration
  def up
    remove_column :posts, :seo_title
  end

  def down
    add_column :posts, :seo_title, :string
  end
end
