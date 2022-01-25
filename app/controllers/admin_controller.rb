class AdminController < ApplicationController
  before_action :authenticate_admin!, only: %i[ healthwise ]

  def index
  end

  def healthwise
    # move all this logic to the healthwise/application controller
    @response = fetch_article
    logger.warn("#{Rails.cache.fetch("/hwid")}")
  end

private
  def fetch_article
    Rails.cache.fetch("/hwid", expires_in: 1.day) do
      token = fetch_healthwise_token
      url = ENV['HEALTHWISE_CONTENT_URL'] + "/articles/ack8827/en-us"
      response = RestClient.get url, { "Authorization": "Bearer #{token}", "X-HW-Version": "1", "Accept": "application/json"}
    end
  end

end
