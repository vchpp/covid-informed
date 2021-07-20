class External < ApplicationRecord
  extend FriendlyId
  friendly_id :en_title, use: :slugged
  scope :filter_by_search, -> (search) { where("en_title like ?", "%#{search}%").or(
                                         where("en_source like ?", "%#{search}%")).or(
                                         where("en_content like ?", "%#{search}%")).or(
                                         where("en_notes like ?", "%#{search}%")).or(
                                         where("zh_tw_title like ?", "%#{search}%")).or(
                                         where("zh_tw_source like ?", "%#{search}%")).or(
                                         where("zh_tw_content like ?", "%#{search}%")).or(
                                         where("zh_tw_notes like ?", "%#{search}%")).or(
                                         where("zh_cn_title like ?", "%#{search}%")).or(
                                         where("zh_cn_source like ?", "%#{search}%")).or(
                                         where("zh_cn_content like ?", "%#{search}%")).or(
                                         where("zh_cn_notes like ?", "%#{search}%")).or(
                                         where("vi_title like ?", "%#{search}%")).or(
                                         where("vi_source like ?", "%#{search}%")).or(
                                         where("vi_content like ?", "%#{search}%")).or(
                                         where("vi_notes like ?", "%#{search}%")).or(
                                         where("hmn_title like ?", "%#{search}%")).or(
                                         where("hmn_source like ?", "%#{search}%")).or(
                                         where("hmn_content like ?", "%#{search}%")).or(
                                         where("hmn_notes like ?", "%#{search}%"))
                                       }
end
