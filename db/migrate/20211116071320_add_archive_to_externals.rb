class AddArchiveToExternals < ActiveRecord::Migration[6.1]
  def change
    add_column :externals, :archive, :boolean, default: false
  end
end
