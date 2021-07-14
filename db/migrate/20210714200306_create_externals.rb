class CreateExternals < ActiveRecord::Migration[6.1]
  def change
    create_table :externals do |t|
      t.string :en_title
      t.string :en_source
      t.string :en_content
      t.string :en_external_link
      t.string :en_notes
      t.string :zh_tw_title
      t.string :zh_tw_source
      t.string :zh_tw_content
      t.string :zh_tw_external_link
      t.string :zh_tw_notes
      t.string :zh_cn_title
      t.string :zh_cn_source
      t.string :zh_cn_content
      t.string :zh_cn_external_link
      t.string :zh_cn_notes
      t.string :vi_title
      t.string :vi_source
      t.string :vi_content
      t.string :vi_external_link
      t.string :vi_notes
      t.string :hmn_title
      t.string :hmn_source
      t.string :hmn_content
      t.string :hmn_external_link
      t.string :hmn_notes
      t.string :languages, array: true, default: []
      t.date :last_version_date

      t.timestamps
    end
  end
end
