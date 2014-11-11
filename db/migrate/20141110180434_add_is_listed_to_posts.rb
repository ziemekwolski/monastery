class AddIsListedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :is_listed, :boolean, default: true, null: false
  end
end
