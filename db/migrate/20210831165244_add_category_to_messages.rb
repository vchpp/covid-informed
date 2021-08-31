class AddCategoryToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :category, :string, default: "general"
  end
end
