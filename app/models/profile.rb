class Profile < ApplicationRecord
  has_one_attached :headshot, dependent: :destroy
  extend FriendlyId
  friendly_id :firstname, use: :slugged
end
