class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true

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
