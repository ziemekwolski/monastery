class RemoveRequiredUserIdFromPosts < ActiveRecord::Migration
  def up
    change_column :posts, :user_id, :integer, null: true
  end

  def down
    change_column :posts, :user_id, :integer, null: false
  end
end
