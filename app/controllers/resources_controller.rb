class ResourcesController < ApplicationController
  def index
    @downloads = Download.all
      .with_attached_en_file
      .with_attached_zh_tw_file
      .with_attached_zh_cn_file
      .with_attached_vi_file
      .with_attached_hmn_file
      .where(archive: false).order('category DESC')
  end
end
