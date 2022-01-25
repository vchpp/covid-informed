class AdminController < ApplicationController
  before_action :authenticate_admin!, only: %i[ healthwise ]

  def index
  end

  def healthwise
    # move all this logic to the healthwise/application controller
    token = fetch_healthwise_token
    logger.warn("HEALTHWISE AUTH TOKEN IS #{token}")
    url = ENV['HEALTHWISE_CONTENT_URL'] + "/articles/ack8827/en-us"
    @response = RestClient.get url, { "Authorization": "Bearer #{token}", "X-HW-Version": "1", "Accept": "application/json"}
    logger.warn("#{@response}")
  end

end
