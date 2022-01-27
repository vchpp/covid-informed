class AboutController < ApplicationController
  before_action :set_profiles

  def index
    @callouts = Callout.all
      .with_attached_en_image
      .with_attached_zh_tw_image
      .with_attached_zh_cn_image
      .with_attached_vi_image
      .with_attached_hmn_image
      .where(archive: false)
      .order('created_at DESC')
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
