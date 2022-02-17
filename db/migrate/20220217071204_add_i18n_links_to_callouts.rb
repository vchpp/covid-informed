class AddI18nLinksToCallouts < ActiveRecord::Migration[6.1]
  def change
    add_column :callouts, :en_link_url, :string
    add_column :callouts, :zh_tw_link_url, :string
    add_column :callouts, :zh_cn_link_url, :string
    add_column :callouts, :vi_link_url, :string
    add_column :callouts, :hmn_link_url, :string
  end
end
