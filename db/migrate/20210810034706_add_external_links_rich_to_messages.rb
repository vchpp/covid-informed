class AddExternalLinksRichToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :en_external_rich_links, :string, default: nil
    add_column :messages, :zh_tw_external_rich_links, :string, default: nil
    add_column :messages, :zh_cn_external_rich_links, :string, default: nil
    add_column :messages, :vi_external_rich_links, :string, default: nil
    add_column :messages, :hmn_external_rich_links, :string, default: nil
  end
end
