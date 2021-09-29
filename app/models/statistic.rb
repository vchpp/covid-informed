class Statistic < ApplicationRecord
  extend FriendlyId
  friendly_id :en_title, use: :slugged
  scope :filter_by_search, -> (search) { where("en_title ilike ?", "%#{search}%").or(
                                         where("en_description ilike ?", "%#{search}%")).or(
                                         where("zh_tw_title ilike ?", "%#{search}%")).or(
                                         where("zh_tw_description ilike ?", "%#{search}%")).or(
                                         where("zh_cn_title ilike ?", "%#{search}%")).or(
                                         where("zh_cn_description ilike ?", "%#{search}%")).or(
                                         where("vi_title ilike ?", "%#{search}%")).or(
                                         where("vi_description ilike ?", "%#{search}%")).or(
                                         where("hmn_title ilike ?", "%#{search}%")).or(
                                         where("hmn_description ilike ?", "%#{search}%")).or(
                                         where("category ilike ?", "%#{search}%"))
                                       }
end
