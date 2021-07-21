class External < ApplicationRecord
  extend FriendlyId
  friendly_id :en_title, use: :slugged
  scope :filter_by_search, -> (search) { where("en_title ilike ?", "%#{search}%").or(
                                         where("en_source ilike ?", "%#{search}%")).or(
                                         where("en_content ilike ?", "%#{search}%")).or(
                                         where("en_notes ilike ?", "%#{search}%")).or(
                                         where("zh_tw_title ilike ?", "%#{search}%")).or(
                                         where("zh_tw_source ilike ?", "%#{search}%")).or(
                                         where("zh_tw_content ilike ?", "%#{search}%")).or(
                                         where("zh_tw_notes ilike ?", "%#{search}%")).or(
                                         where("zh_cn_title ilike ?", "%#{search}%")).or(
                                         where("zh_cn_source ilike ?", "%#{search}%")).or(
                                         where("zh_cn_content ilike ?", "%#{search}%")).or(
                                         where("zh_cn_notes ilike ?", "%#{search}%")).or(
                                         where("vi_title ilike ?", "%#{search}%")).or(
                                         where("vi_source ilike ?", "%#{search}%")).or(
                                         where("vi_content ilike ?", "%#{search}%")).or(
                                         where("vi_notes ilike ?", "%#{search}%")).or(
                                         where("hmn_title ilike ?", "%#{search}%")).or(
                                         where("hmn_source ilike ?", "%#{search}%")).or(
                                         where("hmn_content ilike ?", "%#{search}%")).or(
                                         where("hmn_notes ilike ?", "%#{search}%"))
                                       }
end
