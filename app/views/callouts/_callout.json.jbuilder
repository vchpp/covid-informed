json.extract! callout, :id, :en_title, :en_body, :en_link_name, :zh_tw_title, :zh_tw_body, :zh_tw_link_name, :zh_cn_title, :zh_cn_body, :zh_cn_link_name, :vi_title, :vi_body, :vi_link_name, :hmn_title, :hmn_body, :hmn_link_name, :link, :external_link, :archive, :created_at, :updated_at
json.url callout_url(callout, format: :json)
