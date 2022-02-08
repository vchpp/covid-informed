class AddHealthwiseArticleToComments < ActiveRecord::Migration[6.1]
  def change
    add_reference :comments, :commentable, polymorphic: true, index: true
    Comment.all.each do |m|
      m.commentable_type = 'Message'
      m.commentable_id = m.message_id
      m.save
    end
  end
end
