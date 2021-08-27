class CreateDownloads < ActiveRecord::Migration[6.1]
  def change
    create_table :downloads do |t|
      t.string :en_title
      t.string :zh_tw_title
      t.string :zh_cn_title
      t.string :vi_title
      t.string :hmn_title
      t.string :en_file
      t.string :zh_tw_file
      t.string :zh_cn_file
      t.string :vi_file
      t.string :hmn_file
      t.string :category
      t.boolean :archive

      t.timestamps
    end
  end
end
