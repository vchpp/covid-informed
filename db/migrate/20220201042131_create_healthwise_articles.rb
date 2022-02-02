class CreateHealthwiseArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :healthwise_articles do |t|
      t.string :hwid
      t.string :article_or_topic
      t.string :en_title
      t.json :en_json, default:{}
      t.boolean :en_translated, default:false
      t.string :zh_tw_title
      t.json :zh_tw_json, default:{}
      t.boolean :zh_tw_translated, default:false
      t.string :zh_cn_title
      t.json :zh_cn_json, default:{}
      t.boolean :zh_cn_translated, default:false
      t.string :vi_title
      t.json :vi_json, default:{}
      t.boolean :vi_translated, default:false
      t.string :hmn_title
      t.json :hmn_json, default:{}
      t.boolean :hmn_translated, default:false
      t.string :languages, array:true, default:[]
      t.string :category
      t.boolean :featured, default:false
      t.boolean :archive, default:false

      t.timestamps
    end
  end
end
