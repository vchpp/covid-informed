class AboutController < ApplicationController
  def index
    @profiles = Profile.all
  end
end
