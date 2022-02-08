class RemoveReferenceFromComments < ActiveRecord::Migration[6.1]
  def change
    change_column_null :comments, :message_id, true
  end
end
