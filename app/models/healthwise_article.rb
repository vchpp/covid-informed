class HealthwiseArticle < ApplicationRecord
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
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
