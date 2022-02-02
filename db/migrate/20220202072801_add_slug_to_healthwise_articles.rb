class AddSlugToHealthwiseArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :healthwise_articles, :slug, :string
    add_index :healthwise_articles, :slug, unique: true
  end
end
