class HealthwiseArticlesController < ApplicationController
  before_action :set_healthwise_article, only: %i[ show edit update destroy ]
  before_action :authenticate_admin!, only: %i[ new create edit update destroy ]
  before_action :set_page, only: [:show]

  # GET /healthwise_articles or /healthwise_articles.json
  def index
    @healthwise_articles = HealthwiseArticle.all
  end

  # GET /healthwise_articles/1 or /healthwise_articles/1.json
  def show
    @likes = @healthwise_article.likes.all.order('rct::integer ASC')
    if @healthwise_article.comments
      @all_comments = @healthwise_article.comments
      @admin_comments = @all_comments.order('rct::integer ASC')
      @comments = @all_comments.order(created_at: :desc).limit(10).offset((@page.to_i - 1) * 10)
      @page_count = (@all_comments.count / 10) + 1
    end
    up_likes
    down_likes
    # check if it's custom JSON, if yes, skip fetching
    custom_translations = @healthwise_article.send("#{params[:locale]}_translated".downcase)
    if custom_translations == false
      # check if the HW JSON is out of date, then fetch_article:&update!
      if @healthwise_article.updated_at < Time.now.utc - 1.month
        # change to go through [languages] and update all
        @healthwise_article.languages.each do |l|   # ["en-us", "vi-us"]
          response = fetch_article(@healthwise_article.article_or_topic, @healthwise_article.hwid, l)
          # set JSON
          @healthwise_article.send("#{CI_LOCALE[l]}_json=", JSON.parse(response))
        end
        # save simplified chinese with traditional chinese's values
        @healthwise_article.zh_cn_json = @healthwise_article.zh_tw_json
        @healthwise_article.save
      end
    end
  end

  # GET /healthwise_articles/new
  def new
    @healthwise_article = HealthwiseArticle.new
  end

  # GET /healthwise_articles/1/edit
  def edit
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
        @healthwise_article.send("#{CI_LOCALE[l]}_json=", JSON.parse(response))
        # set titles
        if @healthwise_article.article_or_topic == "Article"
          @healthwise_article.send("#{CI_LOCALE[l]}_title=", JSON.parse(response)["data"]["title"]["consumer"])
        else
          @healthwise_article.send("#{CI_LOCALE[l]}_title=", JSON.parse(response)["data"]["topics"][0]["title"]["consumer"])
        end
      end
    @healthwise_article.zh_cn_json = @healthwise_article.zh_tw_json
    @healthwise_article.zh_cn_title = @healthwise_article.zh_tw_title
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
    @healthwise_article.en_json.to_h
    @healthwise_article.zh_tw_json.to_h
    @healthwise_article.zh_cn_json.to_h
    @healthwise_article.vi_json.to_h
    @healthwise_article.hmn_json.to_h
    @healthwise_article[:languages] = params[:healthwise_article][:languages].first.split("\r\n").map(&:strip)
    respond_to do |format|
      if @healthwise_article.update(healthwise_article_params)
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

  # DELETE /healthwise_articles/1 or /healthwise_articles/1.json
  def destroy
    logger.info "#{current_user.email} destroyed Healthwise #{@healthwise_article.id} with title #{@healthwise_article.en_title}"
    audit! :destroyed_healthwise_article, @healthwise_article, payload: healthwise_article_params
    @healthwise_article.destroy
    respond_to do |format|
      format.html { redirect_to healthwise_articles_url, notice: "Healthwise article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    CI_LOCALE = {
      "vi-us"  => "vi",
      "hm-us" => "hmn",
      "zh-us" => "zh_tw",
      "en-us" => "en"
    }

    HW_LOCALE = {
      "vi"  => "vi-us",
      "hmn" => "hm-us",
      "zh_tw" => "zh-us",
      "zh_cn" => "zh-us",
      "en" => "en-us"
    }

    LOCALES = Regexp.union(
      /en-us/i,
      /zh-us/i,
      /vi-us/i,
      /hm-us/i,
    )

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
      response = RestClient.get url, { "Authorization": "Bearer #{token}", "X-HW-Version": "1", "Accept": "application/json"}
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_healthwise_article
      @healthwise_article = HealthwiseArticle.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def healthwise_article_params
      params.require(:healthwise_article).permit(:hwid, :article_or_topic, :en_title, :en_json, :en_translated, :zh_tw_title, :zh_tw_json, :zh_tw_translated, :zh_cn_title, :zh_cn_json, :zh_cn_translated, :vi_title, :vi_json, :vi_translated, :hmn_title, :hmn_json, :hmn_translated, :category, :featured, :archive, :languages)
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
