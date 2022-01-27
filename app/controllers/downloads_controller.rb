class DownloadsController < ApplicationController
  before_action :set_download, only: %i[ show edit update destroy ]
  before_action :authenticate_admin!, only: %i[ new create show edit update destroy ]

  # GET /downloads or /downloads.json
  def index
    @downloads = Download.all
      .with_attached_en_file
      .with_attached_zh_tw_file
      .with_attached_zh_cn_file
      .with_attached_vi_file
      .with_attached_hmn_file
      .where(archive: false).order('category ASC')
    @other = @downloads.where(category: "Other")
    @downloads = @downloads.filter_by_search(params[:search]) if (params[:search].present?)
  end

  # GET /downloads/1 or /downloads/1.json
  def show
  end

  # GET /downloads/new
  def new
    @download = Download.new
  end

  # GET /downloads/1/edit
  def edit
  end

  # POST /downloads or /downloads.json
  def create
    @download = Download.new(download_params)
    @download.en_file.attach(params[:download][:en_file]) if params[:en_file].present?
    @download.zh_tw_file.attach(params[:download][:zh_tw_file]) if params[:zh_tw_file].present?
    @download.zh_cn_file.attach(params[:download][:zh_cn_file]) if params[:zh_cn_file].present?
    @download.vi_file.attach(params[:download][:vi_file]) if params[:vi_file].present?
    @download.hmn_file.attach(params[:download][:hmn_file]) if params[:hmn_file].present?

    respond_to do |format|
      if @download.save
        format.html { redirect_to @download, notice: "Download was successfully created." }
        format.json { render :show, status: :created, location: @download }
        logger.info "#{current_user.email} created Download #{@download.id} with title #{@download.en_title}"
        audit! :created_download, @download, payload: download_params
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @download.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /downloads/1 or /downloads/1.json
  def update
    @download.en_file.purge if params[:en_file].present?
    @download.zh_tw_file.purge if params[:zh_tw_file].present?
    @download.zh_cn_file.purge if params[:zh_cn_file].present?
    @download.vi_file.purge if params[:vi_file].present?
    @download.hmn_file.purge if params[:hmn_file].present?
    respond_to do |format|
      if @download.update(download_params)
        format.html { redirect_to @download, notice: "Download was successfully updated." }
        format.json { render :show, status: :ok, location: @download }
        logger.info "#{current_user.email} updated Download #{@download.id} with title #{@download.en_title}"
        audit! :updated_download, @download, payload: download_params
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @download.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /downloads/1 or /downloads/1.json
  def destroy
    @download.en_file.purge
    @download.zh_tw_file.purge
    @download.zh_cn_file.purge
    @download.vi_file.purge
    @download.hmn_file.purge
    audit! :destroyed_download, @download, payload: download_params
    @download.destroy
    respond_to do |format|
      format.html { redirect_to downloads_url, notice: "Download was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_download
      @download = Download.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def download_params
      params.require(:download).permit(:en_file, :zh_tw_file, :zh_cn_file, :vi_file, :hmn_file, :en_title, :zh_tw_title, :zh_cn_title, :vi_title, :hmn_title, :category, :archive, :search)
    end
end
