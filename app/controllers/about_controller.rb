class AboutController < ApplicationController
  def index
    @profiles = Profile.all.with_attached_headshot.order('lastname ASC')
    @researchers , @cab_members = [], []
    @janice = @profiles.find_by(fullname: "Janice Tsoh")
    @profiles.each do |profile|
      @researchers << profile if profile.profile_type == 'Research Team Member'
      @cab_members << profile if profile.profile_type == 'CAB member'
    end
    @researchers.delete(@janice)
    @researchers.unshift(@janice)
    @callouts = Callout.where(archive: false).order('created_at DESC')
  end

end
