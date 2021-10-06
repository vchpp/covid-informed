class StatisticsController < ApplicationController
  before_action :set_statistic, only: %i[ show edit update destroy ]

  # GET /statistics or /statistics.json
  def index
    @statistics = Statistic.where(nil).order('en_title ASC') # creates an anonymous scope
    @statistics = @statistics.filter_by_search(params[:search]) if (params[:search].present?)
    @general, @testing, @vaccination, @other = [], [], [], []
    @statistics.each do |e|
      @general << e if e.category == "General"
      @testing << e if e.category == "Testing"
      @vaccination << e if e.category == "Vaccination"
      @other << e if e.category == "Other"
    end
    @leftovers = @statistics.reject{|d| d.category == "General" || d.category == "Other" || d.category == "Vaccination" || d.category == "Testing"}
  end

  # GET /statistics/1 or /statistics/1.json
  def show
  end

  # GET /statistics/new
  def new
    @statistic = Statistic.new
  end

  # GET /statistics/1/edit
  def edit
  end

  # POST /statistics or /statistics.json
  def create
    @statistic = Statistic.new(statistic_params)

    respond_to do |format|
      if @statistic.save
        format.html { redirect_to @statistic, notice: "Statistic was successfully created." }
        format.json { render :show, status: :created, location: @statistic }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @statistic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statistics/1 or /statistics/1.json
  def update
    respond_to do |format|
      if @statistic.update(statistic_params)
        format.html { redirect_to @statistic, notice: "Statistic was successfully updated." }
        format.json { render :show, status: :ok, location: @statistic }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @statistic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statistics/1 or /statistics/1.json
  def destroy
    @statistic.destroy
    respond_to do |format|
      format.html { redirect_to statistics_url, notice: "Statistic was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_statistic
      @statistic = Statistic.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def statistic_params
      params.require(:statistic).permit(:en_title, :en_description, :en_link_name, :zh_tw_title, :zh_tw_description, :zh_tw_link_name, :zh_cn_title, :zh_cn_description, :zh_cn_link_name, :vi_title, :vi_description, :vi_link_name, :hmn_title, :hmn_description, :hmn_link_name, :en_link_url, :zh_tw_link_url, :zh_cn_link_url, :vi_link_url, :hmn_link_url, :category)
    end
end
