class HealthwiseArticle < ApplicationRecord
  has_many :likes, as: :likeable, dependent: :destroy
  extend FriendlyId
  friendly_id :en_title, use: %i(slugged history finders)
end
