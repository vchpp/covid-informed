class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  has_many :votes, dependent: :destroy
  validates :content, presence: true
  validates :rct, presence: true

  def self.to_csv
    attributes = %w{Created_at RCT Content Type ID}
    CSV.generate("\uFEFF", headers: true) do |csv|
      csv << attributes
      all.each do |comment|
        csv << [comment.created_at, comment.rct, comment.content, comment.commentable_type, comment.commentable_id]
      end
    end
  end
end
