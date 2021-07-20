class AddSlugToExternals < ActiveRecord::Migration[6.1]
  def change
    add_column :externals, :slug, :string
    add_index :externals, :slug, unique: true
  end
end
