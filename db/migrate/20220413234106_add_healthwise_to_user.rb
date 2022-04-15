class AddHealthwiseToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :healthwise, :boolean, default: false
  end
end
