class AddIsListedToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :is_listed, :boolean, default: true, null: false
  end
end
