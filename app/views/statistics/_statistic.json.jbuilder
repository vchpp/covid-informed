json.extract! statistic, :id, :en_title, :en_description, :en_link_name, :zh_tw_title, :zh_tw_description, :zh_tw_link_name, :zh_cn_title, :zh_cn_description, :zh_cn_link_name, :vi_title, :vi_description, :vi_link_name, :hmn_title, :hmn_description, :hmn_link_name, :link_url, :category, :created_at, :updated_at
json.url statistic_url(statistic, format: :json)
