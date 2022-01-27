class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[ show edit update destroy ]
  before_action :authenticate_admin!, only: %i[ new index create edit update destroy ]

  # GET /profiles or /profiles.json
  def index
    @profiles = Profile.all.order('lastname ASC')
  end

  # GET /profiles/1 or /profiles/1.json
  def show
    @profile = Profile.with_attached_headshot.friendly.find(params[:id])
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles or /profiles.json
  def create
    @profile = Profile.new(profile_params)
    @profile[:external_links] = params[:profile][:external_links].first.split("\r\n").map(&:strip)
    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: "Profile was successfully created." }
        format.json { render :show, status: :created, location: @profile }
        logger.info "#{current_user.email} created Profile #{@profile.id} with the full name #{@profile.fullname}"
        audit! :created_profile, @profile, payload: profile_params
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1 or /profiles/1.json
  def update
    @profile[:external_links] = params[:profile][:external_links].first.split("\r\n").map(&:strip)
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: "Profile was successfully updated." }
        format.json { render :show, status: :ok, location: @profile }
        logger.info "#{current_user.email} updated Profile #{@profile.id} with the full name #{@profile.fullname}"
        audit! :updated_profile, @profile, payload: profile_params
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1 or /profiles/1.json
  def destroy
    @profile.headshot.purge
    audit! :destroyed_profile, @profile, payload: profile_params
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: "Profile was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def profile_params
      params.require(:profile).permit(:firstname,
                                      :middlename,
                                      :middlename2,
                                      :lastname,
                                      :fullname,
                                      :profile_type,
                                      :archive,
                                      :en_project_title,
                                      :zh_tw_project_title,
                                      :zh_cn_project_title,
                                      :vi_project_title,
                                      :hmn_project_title,
                                      :en_affiliation,
                                      :zh_tw_affiliation,
                                      :zh_cn_affiliation,
                                      :vi_affiliation,
                                      :hmn_affiliation,
                                      :en_bio,
                                      :zh_tw_bio,
                                      :zh_cn_bio,
                                      :vi_bio,
                                      :hmn_bio,
                                      :headshot,
                                      :external_link,
                                      :external_links,)
    end
end
