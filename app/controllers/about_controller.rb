class AboutController < ApplicationController
  before_action :set_profiles

  def index
    @callouts = Callout.all
      .send("with_attached_#{I18n.locale}_image".downcase)
      .order('priority ASC')
      .where(archive: false)
  end

  def researchers
    @researchers
  end

  def lhw
    @lhw
  end

  def cabmembers
    @cab_members
  end

  def set_profiles
    @profiles = Profile.where(archive: false).with_attached_headshot.order('lastname ASC')
    @researchers , @cab_members, @lhw = [], [], []
    @janice = @profiles.find_by(fullname: "Janice Tsoh")
    @profiles.each do |profile|
      @researchers << profile if profile.profile_type == 'Research Team Member'
      @cab_members << profile if profile.profile_type == 'CAB member'
      @lhw << profile if profile.profile_type == 'Lay Health Worker'
    end
    @researchers.delete(@janice)
    @researchers.unshift(@janice)
  end

end
