class Message < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many_attached :images, dependent: :destroy
  has_many_attached :vi_images, dependent: :destroy
  has_many_attached :zh_cn_images, dependent: :destroy
  has_many_attached :zh_tw_images, dependent: :destroy
  has_many_attached :hmn_images, dependent: :destroy
  extend FriendlyId
  friendly_id :en_name, use: :slugged
end
