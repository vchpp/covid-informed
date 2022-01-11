class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy ]
  before_action :authenticate_admin!, only: %i[ new create edit update destroy ]
  before_action :set_page, only: [:show]

  # GET /messages or /messages.json
  def index
    @messages = Message.all
      .with_attached_images
      .with_attached_zh_tw_images
      .with_attached_zh_cn_images
      .with_attached_vi_images
      .with_attached_hmn_images
      .order('created_at ASC')
    @admin_messages = @messages.sort_by(&:category)
    @messages = @messages.where(archive: false)
    # if @message.empty? redirect to new_message_path
    respond_to do |format|
      format.html
      format.csv { send_data @messages.to_csv, filename: "Messages-#{Date.today}.csv" }
    end
  end

  # GET /messages/1 or /messages/1.json
  def show
    @message = Message.with_attached_images.friendly.find(params[:id])
    @likes = @message.likes.all.order('rct::integer ASC')
    @all_comments = Message.friendly.find(params[:id]).comments
    @comments = @all_comments.order(created_at: :desc).limit(10).offset((@page.to_i - 1) * 10)
    @page_count = (@all_comments.count / 10) + 1
    @admin_comments = @comments.order('rct::integer ASC')
    @message_name = @message.send("#{I18n.locale}_name".downcase)
    @message_content = @message.send("#{I18n.locale}_content".downcase)
    @message_external_rich_links = @message.send("#{I18n.locale}_external_rich_links".downcase)
    @message_action_item = @message.send("#{I18n.locale}_action_item".downcase)
    up_likes
    down_likes
    respond_to do |format|
      format.html
      format.csv do
        if (params[:format_data] == 'comments')
          send_data @message.comments_to_csv, filename: "Message##{@message.id}-Comments-#{Date.today}.csv"
        elsif (params[:format_data] == 'likes')
          send_data @message.likes_to_csv, filename: "Message##{@message.id}-Likes-#{Date.today}.csv"
        end
      end
    end
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
        logger.warn("#{current_user.email} created Message #{@message.id} with title #{@message.en_name}")
        audit! :created_message, @message, payload: message_params
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
        logger.warn("#{current_user.email} updated Message #{@message.id} with title #{@message.en_name}")
        audit! :updated_message, @message, payload: message_params
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
      logger.warn("#{current_user.email} deleted Message #{@message.id} with title #{@message.en_name}")
      audit! :destroyed_message, @message, payload: message_params
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.friendly.find(params[:id])
    end

    def set_page
      @page = params[:page] || 1
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
                                      :archive,
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
