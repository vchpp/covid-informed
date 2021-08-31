class AddCategoryToExternals < ActiveRecord::Migration[6.1]
  def change
    add_column :externals, :category, :string, default: "general"
  end
end
