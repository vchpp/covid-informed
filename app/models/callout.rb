class Callout < ApplicationRecord
  has_one_attached :en_image, dependent: :destroy
  has_one_attached :zh_tw_image, dependent: :destroy
  has_one_attached :zh_cn_image, dependent: :destroy
  has_one_attached :vi_image, dependent: :destroy
  has_one_attached :hmn_image, dependent: :destroy
end
