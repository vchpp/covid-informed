class AddLanguagesToDownloads < ActiveRecord::Migration[6.1]
  def change
    add_column :downloads, :languages, :string, array: true, default: []
  end
end
