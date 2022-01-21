class AdminController < ApplicationController
  def index
    token = fetch_token
    logger.warn("HEALTHWISE API TOKEN IS #{token}")
  end
  
  private
    require "rest-client"

    def fetch_token
    Rails.cache.fetch("/healthwise_api_token", expires_in: 1.hour) do
      url = ENV['HEALTHWISE_AUTH_URL'] + "/oauth2/token"
      response = RestClient::Request.execute(
        method: :post,
        url: url,
        user: ENV['HEALTHWISE_CLIENT_ID'],
        password: ENV['HEALTHWISE_CLIENT_SECRET'],
        payload: "grant_type=client_credentials&scope=*"
      )
      JSON.parse(response.body)["access_token"]
    end
  end

end
