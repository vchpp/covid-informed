class HealthwiseArticle < ApplicationRecord
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  extend FriendlyId
  friendly_id :en_title, use: %i(slugged history finders)
end
