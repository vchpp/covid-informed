class AdminController < ApplicationController
  def index
    authenticate_admin!
    cookies[:rct] = 0
  end
end
