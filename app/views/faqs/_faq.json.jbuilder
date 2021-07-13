json.extract! faq, :id, :en_question, :en_answer, :zh_tw_question, :zh_tw_answer, :zh_cn_question, :zh_cn_answer, :hmn_question, :hmn_answer, :vi_question, :vi_answer, :category, :created_at, :updated_at
json.url faq_url(faq, format: :json)
json.en_answer faq.en_answer.to_s
json.zh_tw_answer faq.zh_tw_answer.to_s
json.zh_cn_answer faq.zh_cn_answer.to_s
json.hmn_answer faq.hmn_answer.to_s
json.vi_answer faq.vi_answer.to_s
