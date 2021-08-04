class Message < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many_attached :images, dependent: :destroy
  has_many_attached :vi_images, dependent: :destroy
  has_many_attached :zh_cn_images, dependent: :destroy
  has_many_attached :zh_tw_images, dependent: :destroy
  has_many_attached :hmn_images, dependent: :destroy
  has_rich_text :en_content
  has_rich_text :zh_tw_content
  has_rich_text :zh_cn_content
  has_rich_text :vi_content
  has_rich_text :hmn_content
  extend FriendlyId
  friendly_id :en_name, use: :slugged
end
