class AddArchiveToStatistics < ActiveRecord::Migration[6.1]
  def change
    add_column :statistics, :archive, :boolean, default: false
  end
end
