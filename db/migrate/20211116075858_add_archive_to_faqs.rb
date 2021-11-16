class AddArchiveToFaqs < ActiveRecord::Migration[6.1]
  def change
    add_column :faqs, :archive, :boolean, default: false
  end
end
