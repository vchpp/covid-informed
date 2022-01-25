class AdminController < ApplicationController
  before_action :authenticate_admin!, only: %i[ healthwise_article healthwise_topic ]

  def index
  end

  def healthwise_article
    # move all this logic to the healthwise/application controller
    @response = fetch_article
  end

  def healthwise_topic
    @response = fetch_topic
  end

private
  def fetch_article
    Rails.cache.fetch("/hwid-article", expires_in: 1.day) do
      token = fetch_healthwise_token
      url = ENV['HEALTHWISE_CONTENT_URL'] + "/articles/ack8827/en-us"
      response = RestClient.get url, { "Authorization": "Bearer #{token}", "X-HW-Version": "1", "Accept": "application/json"}
    end
  end

  def fetch_topic
    Rails.cache.fetch("/hwid-topic-json", expires_in: 1.minute) do
      token = fetch_healthwise_token
      url = ENV['HEALTHWISE_CONTENT_URL'] + "/topics/ack9671/en-us?contentOutput=json"
      response = RestClient.get url, { "Authorization": "Bearer #{token}", "X-HW-Version": "1", "Accept": "application/json"}
    end
  end

end
