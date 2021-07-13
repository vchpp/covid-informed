class CreateFaqs < ActiveRecord::Migration[6.1]
  def change
    create_table :faqs do |t|
      t.string :en_question
      t.string :zh_tw_question
      t.string :zh_cn_question
      t.string :hmn_question
      t.string :vi_question
      t.string :category

      t.timestamps
    end
  end
end
