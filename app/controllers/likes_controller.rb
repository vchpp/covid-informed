class LikesController < ApplicationController
  before_action :set_like, only: %i[ show edit update destroy ]
  before_action :authenticate_admin!, only: %i[ index new show edit destroy ]

  # GET /likes or /likes.json
  def index
    @likes = Like.all
    respond_to do |format|
      format.html { redirect_to root_path }
      format.csv { send_data @likes.to_csv, filename: "Likes-#{Date.today}.csv" } if current_user.try(:admin?) 
    end
  end

  # GET /likes/1 or /likes/1.json
  def show
  end

  # GET /likes/new
  def new
    @like = Like.new
  end

  # GET /likes/1/edit
  def edit
  end

  # POST /likes or /likes.json
  def create
    @message = Message.friendly.find(params[:message_id]) if params[:message_id].present?
    @healthwise_article = HealthwiseArticle.friendly.find(params[:healthwise_article_id]) if params[:healthwise_article_id].present?
    @model = @message || @healthwise_article
    existing_likes = []
    @model.likes.each { |like| existing_likes.push(like.rct)}
    @like = @model.likes.new(like_params)
    @like.rct = cookies[:rct] || '0'
    if existing_likes.include?(@like.rct)
      logger.info "#{params[:rct]} tried to like a message a second time, but was redirected"
      redirect_to @message if params[:message_id].present?
      redirect_to @healthwise_article if params[:healthwise_article_id].present?
    else
      respond_to do |format|
        if @like.save
          format.html { redirect_to @message, notice: "Like was successfully created." } if params[:message_id].present?
          format.html { redirect_to @healthwise_article, notice: "Like was successfully created." } if params[:healthwise_article_id].present?
          format.json { render :show, status: :created, location: @message }
          logger.info "Visitor #{params[:rct]} liked message #{@message.id} with title #{@message.en_name}" if params[:message_id].present?
          logger.info "Visitor #{params[:rct]} liked healthwise article #{@healthwise_article.id} with title #{@healthwise_article.en_title}" if params[:healthwise_article_id].present?
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @like.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /likes/1 or /likes/1.json
  def update
    respond_to do |format|
      if @like.update(like_params)
        format.html { redirect_to @message, notice: "Like was successfully updated." }
        format.json { render :show, status: :ok, location: @like }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /likes/1 or /likes/1.json
  def destroy
    @like.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: "Like was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def like_params
      params.require(:like).permit(:up, :down, :rct, :message_id, :healthwise_article_id)
    end
end
