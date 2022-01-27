class CalloutsController < ApplicationController
  before_action :set_callout, only: %i[ show edit update destroy ]
  before_action :authenticate_admin!, only: %i[ new index show create edit update destroy ]

  # GET /callouts or /callouts.json
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

  # GET /callouts/1 or /callouts/1.json
  def show
  end

  # GET /callouts/new
  def new
    @callout = Callout.new
  end

  # GET /callouts/1/edit
  def edit
  end

  # POST /callouts or /callouts.json
  def create
    @callout = Callout.new(callout_params)
    @callout.en_image.attach(params[:callout][:en_image])
    @callout.vi_image.attach(params[:callout][:vi_image])
    @callout.zh_cn_image.attach(params[:callout][:zh_cn_image])
    @callout.zh_tw_image.attach(params[:callout][:zh_tw_image])
    @callout.hmn_image.attach(params[:callout][:hmn_image])

    respond_to do |format|
      if @callout.save
        format.html { redirect_to @callout, notice: "Callout was successfully created." }
        format.json { render :show, status: :created, location: @callout }
        logger.info "#{current_user.email} created Callout #{@callout.id} with title #{@callout.en_title}"
        audit! :created_callout, @callout, payload: callout_params
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @callout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /callouts/1 or /callouts/1.json
  def update
    @callout.en_image.purge if params[:en_image].present?
    @callout.zh_tw_image.purge if params[:zh_tw_image].present?
    @callout.zh_cn_image.purge if params[:zh_cn_image].present?
    @callout.vi_image.purge if params[:vi_image].present?
    @callout.hmn_image.purge if params[:hmn_image].present?
    respond_to do |format|
      if @callout.update(callout_params)
        format.html { redirect_to @callout, notice: "Callout was successfully updated." }
        format.json { render :show, status: :ok, location: @callout }
        logger.info "#{current_user.email} updated Callout #{@callout.id} with title #{@callout.en_title}"
        audit! :updated_callout, @callout, payload: callout_params
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @callout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /callouts/1 or /callouts/1.json
  def destroy
    @callout.en_image.purge
    @callout.zh_tw_image.purge
    @callout.zh_cn_image.purge
    @callout.vi_image.purge
    @callout.hmn_image.purge
    audit! :destroyed_callout, @callout, payload: callout_params
    @callout.destroy
    respond_to do |format|
      format.html { redirect_to callouts_url, notice: "Callout was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_callout
      @callout = Callout.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def callout_params
      params.require(:callout).permit(:en_title, :zh_tw_title, :zh_cn_title, :vi_title, :hmn_title, :link, :external_link, :archive, :en_image, :zh_tw_image, :zh_cn_image, :vi_image, :hmn_image)
    end
end
