class Download < ApplicationRecord
  has_one_attached :en_file, dependent: :destroy
  has_one_attached :zh_tw_file, dependent: :destroy
  has_one_attached :zh_cn_file, dependent: :destroy
  has_one_attached :vi_file, dependent: :destroy
  has_one_attached :hmn_file, dependent: :destroy
end
