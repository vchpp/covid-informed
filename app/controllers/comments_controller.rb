class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
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
    @message = Message.friendly.find(params[:message_id])
    @comment = @message.comments.new(comment_params)
    @comment.rct = cookies[:rct] || '0'
    p @comment
    respond_to do |format|
      if @comment.save
        format.html { redirect_to message_path(@message), notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
        logger.info "Visitor #{params[:rct]} made a comment on message #{@message.id} with title #{@message.en_name}, saying '#{@comment.content}'"
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
    @message = Message.friendly.find(params[:message_id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to message_path(@message), notice: "Comment was successfully destroyed." }
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
