class RemoveReferenceFromLikes < ActiveRecord::Migration[6.1]
  def change
    change_column_null :likes, :message_id, true
  end
end
