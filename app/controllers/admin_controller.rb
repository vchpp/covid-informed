class AdminController < ApplicationController

  def index
    logger.warn("#{fetch_hw_token}")
  end

end
