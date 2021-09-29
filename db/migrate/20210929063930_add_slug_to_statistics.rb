class AddSlugToStatistics < ActiveRecord::Migration[6.1]
  def change
    add_column :statistics, :slug, :string
    add_index :statistics, :slug, unique: true
  end
end
