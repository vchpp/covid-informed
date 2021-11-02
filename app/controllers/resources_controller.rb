class ResourcesController < ApplicationController
  def index
    @downloads = Download.all
      .with_attached_en_file
      .with_attached_zh_tw_file
      .with_attached_zh_cn_file
      .with_attached_vi_file
      .with_attached_hmn_file
      .where(archive: false).order('category ASC')
    @other = @downloads.where(category: "Other")

    @statistics = Statistic.where(nil).order('en_title ASC') # creates an anonymous scope
    @statistics = @statistics.filter_by_search(params[:search]) if (params[:search].present?)
    @general, @testing, @vaccination, @other, @featured = [], [], [], [], []
    @statistics.each do |e|
      if e.featured == true
        @featured << e
      elsif e.featured == false
        @general << e if e.category == "General"
        @testing << e if e.category == "Testing"
        @vaccination << e if e.category == "Vaccination"
        @other << e if e.category == "Other"
      end
    end
    @leftovers = @statistics.reject{|d| d.category == "General" || d.category == "Other" || d.category == "Vaccination" || d.category == "Testing"}
  end
end
