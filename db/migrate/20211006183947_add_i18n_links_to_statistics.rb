class AddI18nLinksToStatistics < ActiveRecord::Migration[6.1]
  def change
    add_column :statistics, :en_link_url, :string
    add_column :statistics, :zh_tw_link_url, :string
    add_column :statistics, :zh_cn_link_url, :string
    add_column :statistics, :vi_link_url, :string
    add_column :statistics, :hmn_link_url, :string
  end
end
