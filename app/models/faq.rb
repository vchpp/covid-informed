class Faq < ApplicationRecord
  has_rich_text :en_answer
  has_rich_text :zh_tw_answer
  has_rich_text :zh_cn_answer
  has_rich_text :hmn_answer
  has_rich_text :vi_answer
  has_many :rich_texts,
    class_name: "ActionText::RichText",
    as: :record,
    inverse_of: :record,
    autosave: true,
    dependent: :destroy
  extend FriendlyId
  friendly_id :en_question, use: :slugged
  scope :filter_by_category, -> (category) { where category: category }
  scope :filter_by_search, -> (search) { joins(:rich_texts).where("action_text_rich_texts.body ilike ?", "%#{search}%").or(
                                         where("en_question ilike ?", "%#{search}%")).or(
                                         where("zh_tw_question ilike ?", "%#{search}%")).or(
                                         where("zh_cn_question ilike ?", "%#{search}%")).or(
                                         where("vi_question ilike ?", "%#{search}%")).or(
                                         where("hmn_question ilike ?", "%#{search}%")).uniq
                                       }
end
