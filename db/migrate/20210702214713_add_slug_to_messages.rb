class AddSlugToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :slug, :string
    add_index :messages, :slug, unique: true
  end
end
