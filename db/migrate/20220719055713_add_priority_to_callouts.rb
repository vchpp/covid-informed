class AddPriorityToCallouts < ActiveRecord::Migration[6.1]
  def change
    add_column :callouts, :priority, :integer, default: nil
  end
end
