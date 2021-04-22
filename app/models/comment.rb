class Comment < ApplicationRecord
  belongs_to :message
  has_many :votes, dependent: :destroy
  validates :content, presence: true, uniqueness: true
  validates :rct, presence: true
  validates :message_id, presence: true, allow_nil: false
end
