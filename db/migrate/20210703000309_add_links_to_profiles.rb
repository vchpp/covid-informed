class AddLinksToProfiles < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :external_links, :string, array: true, default: []
  end
end
