class ResourcesController < ApplicationController
  def index
    @downloads = Download.where(archive: false).order('category DESC')
  end
end
