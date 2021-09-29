class CreateStatistics < ActiveRecord::Migration[6.1]
  def change
    create_table :statistics do |t|
      t.string :en_title
      t.string :en_description
      t.string :en_link_name
      t.string :zh_tw_title
      t.string :zh_tw_description
      t.string :zh_tw_link_name
      t.string :zh_cn_title
      t.string :zh_cn_description
      t.string :zh_cn_link_name
      t.string :vi_title
      t.string :vi_description
      t.string :vi_link_name
      t.string :hmn_title
      t.string :hmn_description
      t.string :hmn_link_name
      t.string :link_url
      t.string :category

      t.timestamps
    end
  end
end
