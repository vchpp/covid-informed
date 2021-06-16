class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy ]

  # GET /messages or /messages.json
  def index
    @messages = Message.all.with_attached_images
    # if @message.empty? redirect to new_message_path
  end

  # GET /messages/1 or /messages/1.json
  def show
    p "***** LOCALE IS ****** " + params[:locale]
    # @message = Message.find(params[:id])
    @message = Message.with_attached_images.find(params[:id])
    @comments = Message.find(params[:id]).comments
    case
      when params[:locale] == "en"
        @message_name = Message.find(params[:id]).en_name
        @message_content = Message.find(params[:id]).en_content
      when params[:locale] == "zh_TW"
        @message_name = Message.find(params[:id]).zh_tw_name
        @message_content = Message.find(params[:id]).zh_tw_content
      when params[:locale] == "zh_CN"
        @message_name = Message.find(params[:id]).zh_cn_name
        @message_content = Message.find(params[:id]).zh_cn_content
      when params[:locale] == "vi"
        @message_name = Message.find(params[:id]).vi_name
        @message_content = Message.find(params[:id]).vi_content
      when params[:locale] == "hmn"
        @message_name = Message.find(params[:id]).hmn_name
        @message_content = Message.find(params[:id]).hmn_content
    end
    p @message_content
    up_likes
    down_likes
  end

  # GET /messages/new
  def new
    authenticate_admin!
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
    authenticate_admin!
  end

  # POST /messages or /messages.json
  def create
    authenticate_admin!
    @message = Message.new(message_params)
    @message.images.attach(params[:message][:images])

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: "Message was successfully created." }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    authenticate_admin!
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: "Message was successfully updated." }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    authenticate_admin!
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:en_name, :en_content, :zh_tw_name, :zh_tw_content, :zh_cn_name, :zh_cn_content, :vi_name, :vi_content, :hmn_name, :hmn_content, images: [])
    end

    def up_likes
      message = Message.find(params[:id])
      likes = message.likes.all
      up = likes.map do |like| like.up end
      @up_likes = up.map(&:to_i).reduce(0, :+)
    end

    def down_likes
      message = Message.find(params[:id])
      likes = message.likes.all
      down = likes.map do |like| like.down end
      @down_likes = down.map(&:to_i).reduce(0, :+)
    end
end
