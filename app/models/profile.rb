class Profile < ApplicationRecord
  has_one_attached :headshot, dependent: :destroy
end
