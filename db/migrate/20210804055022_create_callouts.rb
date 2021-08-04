class CreateCallouts < ActiveRecord::Migration[6.1]
  def change
    create_table :callouts do |t|
      t.string :en_title
      t.string :en_body
      t.string :en_link_name
      t.string :zh_tw_title
      t.string :zh_tw_body
      t.string :zh_tw_link_name
      t.string :zh_cn_title
      t.string :zh_cn_body
      t.string :zh_cn_link_name
      t.string :vi_title
      t.string :vi_body
      t.string :vi_link_name
      t.string :hmn_title
      t.string :hmn_body
      t.string :hmn_link_name
      t.string :link
      t.boolean :external_link
      t.boolean :archive

      t.timestamps
    end
  end
end
