class AboutController < ApplicationController
  def index
    @profiles = Profile.all.with_attached_headshot.order('lastname ASC')
    @researchers , @cab_members , @janice = [], [], []
    @janice = @profiles.find_by(lastname: "Tsoh")
    @profiles.each do |profile|
      @researchers << profile if profile.profile_type == 'Research Team Member'
      @cab_members << profile if profile.profile_type == 'CAB member'
    end
    @researchers.delete(@profiles.find_by(lastname: "Tsoh"))
    @researchers.unshift(@janice)
  end

end
