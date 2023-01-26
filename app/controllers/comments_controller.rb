class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :authenticate_admin!, only: %i[ index new show edit destroy ]

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
    respond_to do |format|
      format.html { redirect_to root_path }
      format.csv { send_data @comments.to_csv, filename: "Comments-#{Date.today}.csv" } if current_user.try(:admin?) 
    end
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @message = Message.friendly.find(params[:message_id]) if params[:message_id].present?
    @healthwise_article = HealthwiseArticle.friendly.find(params[:healthwise_article_id]) if params[:healthwise_article_id].present?
    @model = @message || @healthwise_article
    @comment = @model.comments.new(comment_params)
    @comment.rct = cookies[:rct] || '0'
    respond_to do |format|
      if @comment.save
        format.html { redirect_to message_path(@message), notice: "Comment was successfully created." } if params[:message_id].present?
        format.html { redirect_to healthwise_article_path(@healthwise_article), notice: "Comment was successfully created." } if params[:healthwise_article_id].present?
        format.json { render :show, status: :created, location: @comment }
        logger.warn "Visitor with RCT=#{cookies[:rct]} made a comment on message #{@message.id} with title #{@message.en_name}, saying '#{@comment.content}'" if params[:message_id].present?
        logger.warn "Visitor with RCT=#{cookies[:rct]} made a comment on message #{@healthwise_article.id} with title #{@healthwise_article.en_title}, saying '#{@comment.content}'" if params[:healthwise_article_id].present?
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    authenticate_admin!
    @message = Message.friendly.find(params[:message_id]) if params[:message_id].present?
    @healthwise_article = HealthwiseArticle.friendly.find(params[:healthwise_article_id]) if params[:healthwise_article_id].present?
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to message_path(@message), notice: "Comment was successfully destroyed." } if params[:message_id].present?
      format.html { redirect_to healthwise_article_path(@healthwise_article), notice: "Comment was successfully destroyed." } if params[:healthwise_article_id].present?
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:content)
    end
end
