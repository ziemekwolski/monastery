class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :name
      t.attachment :file
      t.timestamps
    end
  end
end
