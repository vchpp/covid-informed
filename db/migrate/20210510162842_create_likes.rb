class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.string :up, default: '0'
      t.string :down, default: '0'
      t.string :rct
      t.references :message, null: false, foreign_key: true

      t.timestamps
    end
  end
end
