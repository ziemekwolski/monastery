class AddUploadIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :upload_id, :integer
  end
end
