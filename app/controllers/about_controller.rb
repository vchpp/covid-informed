class AboutController < ApplicationController
  def index
    @profiles = Profile.all.with_attached_headshot

    @researchers , @cab_members = [], []
    @profiles.each do |profile|
      @researchers << profile if profile.profile_type == 'Research Team Member'
      @cab_members << profile if profile.profile_type == 'CAB member'
    end
  end

end
