class AddHealthwiseArticleToLikes < ActiveRecord::Migration[6.1]
  def change
    add_reference :likes, :likeable, polymorphic: true, index: true
    Like.all.each do |m|
      m.likeable_type = 'Message'
      m.likeable_id = m.message_id
      m.save
    end
  end
end
