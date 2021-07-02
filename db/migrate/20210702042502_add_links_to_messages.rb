class AddLinksToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :en_action_item, :string
    add_column :messages, :zh_tw_action_item, :string
    add_column :messages, :zh_cn_action_item, :string
    add_column :messages, :vi_action_item, :string
    add_column :messages, :hmn_action_item, :string
    add_column :messages, :external_links, :string, array: true, default: []
  end
end
