class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.string :firstname
      t.string :middlename
      t.string :middlename2
      t.string :lastname
      t.string :profile_type
      t.string :external_link
      t.string :en_project_title
      t.string :zh_tw_project_title
      t.string :zh_cn_project_title
      t.string :vi_project_title
      t.string :hmn_project_title
      t.string :en_affiliation
      t.string :zh_tw_affiliation
      t.string :zh_cn_affiliation
      t.string :vi_affiliation
      t.string :hmn_affiliation
      t.string :en_bio
      t.string :zh_tw_bio
      t.string :zh_cn_bio
      t.string :vi_bio
      t.string :hmn_bio

      t.timestamps
    end
  end
end
