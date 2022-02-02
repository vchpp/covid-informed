class HealthwiseArticle < ApplicationRecord
  extend FriendlyId
  friendly_id :en_title, use: %i(slugged history finders)
end
