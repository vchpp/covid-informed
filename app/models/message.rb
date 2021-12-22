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
  has_rich_text :en_action_item
  has_rich_text :zh_tw_action_item
  has_rich_text :zh_cn_action_item
  has_rich_text :vi_action_item
  has_rich_text :hmn_action_item
  has_rich_text :en_external_rich_links
  has_rich_text :zh_tw_external_rich_links
  has_rich_text :zh_cn_external_rich_links
  has_rich_text :vi_external_rich_links
  has_rich_text :hmn_external_rich_links
  extend FriendlyId
  friendly_id :en_name, use: :slugged

  def self.to_csv
    attributes = %w{id en_name}

    CSV.generate("\uFEFF", headers: true) do |csv|
      csv << attributes
      all.each do |message|
        csv << attributes.map{ |attr| message.send(attr) }
      end
    end
  end

  def comments_to_csv
    attributes = %w{Created_at RCT Content}
    CSV.generate("\uFEFF", headers: true) do |csv|
      csv << attributes
      if comments
        comments.each do |comment|
          csv << [comment.created_at, comment.rct, comment.content]
        end
      end
    end
  end

  def likes_to_csv
    attributes = %w{Created_at RCT Uplikes Downlikes}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      if likes
        likes.each do |likes|
          csv << [likes.created_at, likes.rct, likes.up, likes.down]
        end
      end
    end
  end
end
