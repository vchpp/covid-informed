class AboutController < ApplicationController
  def index
    @profiles = Profile.all.with_attached_headshot
  end
end
