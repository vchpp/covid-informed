class AddFeaturedToStatistics < ActiveRecord::Migration[6.1]
  def change
    add_column :statistics, :featured, :boolean, default: false
  end
end
