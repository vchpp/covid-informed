class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  has_many :votes, dependent: :destroy
  validates :content, presence: true
  validates :rct, presence: true
end
