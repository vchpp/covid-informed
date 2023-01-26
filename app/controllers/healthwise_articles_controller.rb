class HealthwiseArticlesController < ApplicationController
  before_action :set_healthwise_article, only: %i[ show edit update upgrade refresh destroy ]
  before_action :authenticate_admin!, only: %i[ new create edit update upgrade refresh destroy ]
  before_action :set_page, only: [:show]

  # GET /healthwise_articles or /healthwise_articles.json
  def index
    @healthwise_articles = HealthwiseArticle.where(nil).order('en_title ASC') # creates an anonymous scope
    @csv_healthwise_articles = @healthwise_articles
    @admin_healthwise_articles = @healthwise_articles.sort_by(&:category)
    @healthwise_articles = @healthwise_articles.where(archive: false)
    @healthwise_articles = @healthwise_articles.filter_by_search(params[:search]) if (params[:search].present?)
    @general, @testing, @vaccination, @wellness, @featured = [], [], [], [], []
    @healthwise_articles.each do |h|
      if h.featured == true
        @featured << h
        # @featured.sort_by(&:category) but for array methods
      elsif h.featured == false
        @general << h if h.category == "General"
        @testing << h if h.category == "Testing"
        @vaccination << h if h.category == "Vaccination"
        @wellness << h if h.category == "Wellness"
      end
    end
    respond_to do |format|
      format.html
      format.csv { send_data @csv_healthwise_articles.to_csv, filename: "HealthwiseArticles-#{Date.today}.csv"} if current_user.try(:admin?)
    end
    # logger.warn fetch_hw_token
  end

  # GET /healthwise_articles/1 or /healthwise_articles/1.json
  def show
    if @healthwise_article.archive?
      if current_user.try(:admin?)
        flash.now[:alert] = "Healthwise Article is currently archived"
      else
        redirect_to healthwise_articles_url, alert: "Healthwise Article not available."
      end
    end
    @likes = @healthwise_article.likes.all.order('rct::integer ASC')
    if @healthwise_article.comments
      @all_comments = @healthwise_article.comments
      @admin_comments = @all_comments.order('rct::integer ASC')
      @comments = @all_comments.order(created_at: :desc).limit(10).offset((@page.to_i - 1) * 10)
      @page_count = (@all_comments.count / 10) + 1
    end
    up_likes
    down_likes
    respond_to do |format|
      format.html
      format.csv do
        if (params[:format_data] == 'comments')
          send_data @healthwise_article.comments_to_csv, filename: "HealthwiseArticle##{@healthwise_article.id}-Comments-#{Date.today}.csv" if current_user.try(:admin?)
        elsif (params[:format_data] == 'likes')
          send_data @healthwise_article.likes_to_csv, filename: "HealthwiseArticle##{@healthwise_article.id}-Likes-#{Date.today}.csv" if current_user.try(:admin?) 
        end
      end
    end
  end

  # GET /healthwise_articles/new
  def new
    @healthwise_article = HealthwiseArticle.new
  end

  # GET /healthwise_articles/1/edit
  def edit
    # logger.warn("#{@healthwise_article.attributes.values }")
  end

  # POST /healthwise_articles or /healthwise_articles.json
  def create
    # take params and make article.new
    @healthwise_article = HealthwiseArticle.new(healthwise_article_params)
    # check if article or topic
    # fetch article for available languages
    # store them in @healthwise_article.languages
    @healthwise_article.languages = fetch_languages(@healthwise_article.article_or_topic, @healthwise_article.hwid)
    # ["hm-us\r\nen-us\r\nzh-us\r\nvi-us"].split("\r\n").map(&:strip) works
    # ["en-us", "vi-us"]
    # fetch article's JSON from hwid for [languages], otherwise default to english
    @healthwise_article.languages.each do |l|   # ["en-us", "vi-us"]
      response = fetch_article(@healthwise_article.article_or_topic, @healthwise_article.hwid, l)
       # set JSON
      @healthwise_article.send("#{CI_LOCALE[l]}_json=".downcase, JSON.parse(response))
      # set titles
      if @healthwise_article.article_or_topic == "Article"
        @healthwise_article.send("#{CI_LOCALE[l]}_title=".downcase, JSON.parse(response)["data"]["title"]["consumer"])
      else
        @healthwise_article.send("#{CI_LOCALE[l]}_title=".downcase, JSON.parse(response)["data"]["topics"][0]["title"]["consumer"])
      end
    end

    backfill_english_json
    set_simplified_chinese

    # save
    respond_to do |format|
      if @healthwise_article.save
        format.html { redirect_to @healthwise_article, notice: "Healthwise article was successfully created." }
        format.json { render :show, status: :created, location: @healthwise_article }
        logger.info "#{current_user.email} created Healthwise #{@healthwise_article.id} with title #{@healthwise_article.en_title}"
        audit! :created_healthwise_article, @healthwise_article, payload: healthwise_article_params
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @healthwise_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /healthwise_articles/1 or /healthwise_articles/1.json
  def update
    @healthwise_article[:languages] = params[:healthwise_article][:languages].first.split("\r\n").map(&:strip)
    @healthwise_article.hmn_pdf.purge if params[:hmn_pdf].present? || params[:hmn_pdf_purge].present?
    @healthwise_article.vi_pdf.purge if params[:vi_pdf].present? || params[:vi_pdf_purge].present?
    @healthwise_article.en_pdf.purge if params[:en_pdf].present? || params[:en_pdf_purge].present?
    @healthwise_article.zh_tw_pdf.purge if params[:zh_tw_pdf].present? || params[:zh_tw_pdf_purge].present?
    @healthwise_article.zh_cn_pdf.purge if params[:zh_cn_pdf].present? || params[:zh_cn_pdf_purge].present?
    respond_to do |format|
      if @healthwise_article.update(healthwise_article_params)
        logger.warn healthwise_article_params
        format.html { redirect_to @healthwise_article, notice: "Healthwise article was successfully updated." }
        format.json { render :show, status: :ok, location: @healthwise_article }
        logger.info "#{current_user.email} updated Healthwise #{@healthwise_article.id} with title #{@healthwise_article.en_title}"
        audit! :updated_healthwise_article, @healthwise_article, payload: healthwise_article_params
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @healthwise_article.errors, status: :unprocessable_entity }
      end
    end
  end

  def refresh
    # check if it's custom JSON, if yes, skip fetching
    @healthwise_article.languages = fetch_languages(@healthwise_article.article_or_topic, @healthwise_article.hwid)

    @healthwise_article.languages.each do |l|   # ["en-us", "vi-us"]
      if @healthwise_article.send("#{CI_LOCALE[l]}_translated".downcase) ==  false
        response = fetch_article(@healthwise_article.article_or_topic, @healthwise_article.hwid, l)
         # set JSON
        @healthwise_article.send("#{CI_LOCALE[l]}_json=".downcase,JSON.parse(response))
        # set titles
        if @healthwise_article.article_or_topic == "Article"
          @healthwise_article.send("#{CI_LOCALE[l]}_title=".downcase, JSON.parse(response)["data"]["title"]["consumer"])
        else
          @healthwise_article.send("#{CI_LOCALE[l]}_title=".downcase, JSON.parse(response)["data"]["topics"][0]["title"]["consumer"])
        end
        # save simplified chinese with traditional chinese's values
        set_simplified_chinese
      end
    end

    respond_to do |format|
      if @healthwise_article.update(@healthwise_article.attributes)
        format.html { redirect_to @healthwise_article, notice: "Healthwise article was successfully refreshed from the HW API." }
        format.json { render :show, status: :ok, location: @healthwise_article }
        logger.info "#{current_user.email} refreshed Healthwise #{@healthwise_article.id} with title #{@healthwise_article.en_title}"
        audit! :refreshed_healthwise_article, @healthwise_article, payload: @healthwise_article.attributes
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @healthwise_article.errors, status: :unprocessable_entity }
      end
    end
  end

  def upgrade
    backfill_english_json
    set_simplified_chinese

    respond_to do |format|
      if @healthwise_article.update(@healthwise_article.attributes)
        format.html { redirect_to @healthwise_article, notice: "Healthwise article was successfully upgraded to use custom translations." }
        format.json { render :show, status: :ok, location: @healthwise_article }
        logger.info "#{current_user.email} upgraded Healthwise #{@healthwise_article.id} with title #{@healthwise_article.en_title}"
        audit! :upgraded_healthwise_article, @healthwise_article, payload: @healthwise_article.attributes
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @healthwise_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /healthwise_articles/1 or /healthwise_articles/1.json
  def destroy
    @healthwise_article.hmn_pdf.purge
    @healthwise_article.vi_pdf.purge
    @healthwise_article.en_pdf.purge
    @healthwise_article.zh_tw_pdf.purge
    @healthwise_article.zh_cn_pdf.purge
    logger.info "#{current_user.email} destroyed Healthwise #{@healthwise_article.id} with title #{@healthwise_article.en_title}"
    audit! :destroyed_healthwise_article, @healthwise_article, payload: @healthwise_article.attributes
    @healthwise_article.destroy
    respond_to do |format|
      format.html { redirect_to healthwise_articles_url, notice: "Healthwise article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def fetch_languages(type, hwid)
      token = fetch_hw_token
      url = ENV['HEALTHWISE_CONTENT_URL'] + "/#{type}s/#{hwid}"
      response = RestClient.get url, { "Authorization": "Bearer #{token}", "X-HW-Version": "1", "Accept": "application/json"}
      # iterate over json hash to match for available locales #
      languages = []
      JSON.parse(response)['links']['localizations'].map {|l| languages << l[0] if l[0].match(LOCALES)}
      # return an array
      return languages.uniq
    end

    def fetch_article(type, hwid, language)
      token = fetch_hw_token
      url = ENV['HEALTHWISE_CONTENT_URL'] + "/#{type}s/#{hwid}/#{language}"
      begin
        response = RestClient.get url, { "Authorization": "Bearer #{token}", "X-HW-Version": "1", "Accept": "application/json"}
      rescue => e
        e.response
        response = nil
      end
    end

    def set_simplified_chinese
      @healthwise_article.zh_cn_json = @healthwise_article.zh_tw_json if @healthwise_article.zh_tw_json.present?
      @healthwise_article.zh_cn_title = @healthwise_article.zh_tw_title if @healthwise_article.zh_tw_title.present?
    end

    def backfill_english_json # used in create/upgrade
      # compare @healthwise_article.languages against CI_LOCALE to find missing languages
      CI_LOCALE.each do |key, value|
        if not @healthwise_article.languages.include?(key)
          # overwrite english title and json onto missing languages
          @healthwise_article.send("#{value}_json=".downcase, @healthwise_article.en_json)
          # set titles
          if @healthwise_article.article_or_topic == "Article"
            @healthwise_article.send("#{value}_title=".downcase, @healthwise_article.en_json["data"]["title"]["consumer"])
          else
            @healthwise_article.send("#{value}_title=".downcase, @healthwise_article.en_json["data"]["topics"][0]["title"]["consumer"])
          end
        end
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_healthwise_article
      @healthwise_article = HealthwiseArticle.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def healthwise_article_params
      params.require(:healthwise_article).permit(:hwid, :article_or_topic, :en_title, :en_json, :en_translated, :en_pdf_purge, :zh_tw_title, :zh_tw_json, :zh_tw_translated, :zh_tw_pdf_purge, :zh_cn_title, :zh_cn_json, :zh_cn_translated, :zh_cn_pdf_purge, :vi_title, :vi_json, :vi_translated, :vi_pdf_purge, :hmn_title, :hmn_json, :hmn_translated, :hmn_pdf_purge, :en_rich_text, :zh_tw_rich_text, :zh_cn_rich_text, :vi_rich_text, :hmn_rich_text, :category, :featured, :archive, :languages, en_pdf: [], zh_tw_pdf: [],  zh_cn_pdf: [], vi_pdf: [], hmn_pdf: [])
    end

    def set_page
      @page = params[:page] || 1
    end

    def up_likes
      likes = @healthwise_article.likes.all
      up = likes.map do |like| like.up end
      @up_likes = up.map(&:to_i).reduce(0, :+)
    end

    def down_likes
      likes = @healthwise_article.likes.all
      down = likes.map do |like| like.down end
      @down_likes = down.map(&:to_i).reduce(0, :+)
    end
end
