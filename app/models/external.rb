class External < ApplicationRecord
  extend FriendlyId
  friendly_id :en_title, use: :slugged
end
