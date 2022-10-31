class HealthwiseArticle < ApplicationRecord
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_rich_text :en_rich_text
  has_rich_text :zh_tw_rich_text
  has_rich_text :zh_cn_rich_text
  has_rich_text :vi_rich_text
  has_rich_text :hmn_rich_text
  has_many_attached :en_pdf
  has_many_attached :zh_tw_pdf
  has_many_attached :zh_cn_pdf
  has_many_attached :vi_pdf
  has_many_attached :hmn_pdf
  extend FriendlyId
  friendly_id :en_title, use: %i(slugged history finders)
  scope :filter_by_search, -> (search) { where("en_title ilike ?", "%#{search}%").or(
                                        where("zh_tw_title ilike ?", "%#{search}%")).or(
                                        where("vi_title ilike ?", "%#{search}%")).or(
                                        where("hmn_title ilike ?", "%#{search}%"))
                                        }

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

  def should_generate_new_friendly_id? #will change the slug if the en_title changed
    en_title_changed?
  end

end
