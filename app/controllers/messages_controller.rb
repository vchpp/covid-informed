class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy ]
  before_action :authenticate_admin!, only: %i[ new create edit update destroy ]

  # GET /messages or /messages.json
  def index
    @messages = Message.all
      .with_attached_images
      .with_attached_zh_tw_images
      .with_attached_zh_cn_images
      .with_attached_vi_images
      .with_attached_hmn_images
      .sort_by(&:created_at)
    # if @message.empty? redirect to new_message_path
  end

  # GET /messages/1 or /messages/1.json
  def show
    @message = Message.with_attached_images.friendly.find(params[:id])
    @comments = Message.friendly.find(params[:id]).comments
    case
      when params[:locale] == "en"
        @message_name = @message.en_name
        @message_content = @message.en_content
        @message_external_rich_links = @message.en_external_rich_links
        @message_action_item = @message.en_action_item
      when params[:locale] == "zh_TW"
        @message_name = @message.zh_tw_name
        @message_content = @message.zh_tw_content
        @message_external_rich_links = @message.zh_tw_external_rich_links
        @message_action_item = @message.zh_tw_action_item
      when params[:locale] == "zh_CN"
        @message_name = @message.zh_cn_name
        @message_content = @message.zh_cn_content
        @message_external_rich_links = @message.zh_cn_external_rich_links
        @message_action_item = @message.zh_cn_action_item
      when params[:locale] == "vi"
        @message_name = @message.vi_name
        @message_content = @message.vi_content
        @message_external_rich_links = @message.vi_external_rich_links
        @message_action_item = @message.vi_action_item
      when params[:locale] == "hmn"
        @message_name = @message.hmn_name
        @message_content = @message.hmn_content
        @message_external_rich_links = @message.hmn_external_rich_links
        @message_action_item = @message.hmn_action_item
    end
    up_likes
    down_likes
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages or /messages.json
  def create
    @message = Message.new(message_params)
    @message[:external_links] = params[:message][:external_links].first.split("\r\n").map(&:strip) if params[:message][:external_links].present?
    @message.images.attach(params[:message][:images]) if params[:images].present?
    @message.images.attach(params[:message][:vi_images]) if params[:vi_images].present?
    @message.images.attach(params[:message][:zh_cn_images]) if params[:zh_cn_images].present?
    @message.images.attach(params[:message][:zh_tw_images]) if params[:zh_tw_images].present?
    @message.images.attach(params[:message][:hmn_images]) if params[:hmn_images].present?

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
    @message[:external_links] = params[:message][:external_links].first.split("\r\n").map(&:strip) if params[:message][:external_links].present?
    @message.images.purge if params[:images].present?
    @message.zh_tw_images.purge if params[:zh_tw_images].present?
    @message.zh_cn_images.purge if params[:zh_cn_images].present?
    @message.vi_images.purge if params[:vi_images].present?
    @message.hmn_images.purge if params[:hmn_images].present?
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
    @message.images.purge
    @message.zh_tw_images.purge
    @message.zh_cn_images.purge
    @message.vi_images.purge
    @message.hmn_images.purge
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:en_name,
                                      :en_content,
                                      :en_action_item,
                                      :zh_tw_name,
                                      :zh_tw_content,
                                      :zh_tw_action_item,
                                      :zh_cn_name,
                                      :zh_cn_content,
                                      :zh_cn_action_item,
                                      :vi_name,
                                      :vi_content,
                                      :vi_action_item,
                                      :hmn_name,
                                      :hmn_content,
                                      :hmn_action_item,
                                      :external_links,
                                      :en_external_rich_links,
                                      :zh_tw_external_rich_links,
                                      :zh_cn_external_rich_links,
                                      :vi_external_rich_links,
                                      :hmn_external_rich_links,
                                      :survey_link,
                                      :category,
                                      images: [],
                                      vi_images: [],
                                      zh_tw_images: [],
                                      zh_cn_images: [],
                                      hmn_images: [],
                                    )
    end

    def up_likes
      message = Message.friendly.find(params[:id])
      likes = message.likes.all
      up = likes.map do |like| like.up end
      @up_likes = up.map(&:to_i).reduce(0, :+)
    end

    def down_likes
      message = Message.friendly.find(params[:id])
      likes = message.likes.all
      down = likes.map do |like| like.down end
      @down_likes = down.map(&:to_i).reduce(0, :+)
    end
end
