class HealthwiseArticlesController < ApplicationController
  before_action :set_healthwise_article, only: %i[ show edit update destroy ]

  # GET /healthwise_articles or /healthwise_articles.json
  def index
    @healthwise_articles = HealthwiseArticle.all
  end

  # GET /healthwise_articles/1 or /healthwise_articles/1.json
  def show
    # check if it's custom JSON, if yes, skip fetching
    if @healthwise_article.send("#{I18n.locale}_translated".downcase) == false
      # check if the HW JSON is out of date, then fetch_article:&update!
      if @healthwise_article.updated_at < Time.now - 7.days
        if @healthwise_article.type == "article"
          @healthwise_article.send("#{I18n.locale}_json".downcase= fetch_article(@healthwise_article.hwid, HW_LOCALE[I18n.locale]))
        else
          @healthwise_article.send("#{I18n.locale}_json".downcase= fetch_topic(@healthwise_article.hwid, HW_LOCALE[I18n.locale]))
        end
        @healthwise_article.update!
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
    if @healthwise_article.type == "Article"
      # fetch article for available languages
      # store them in @healthwise_article.languages
      @healthwise_article.languages = @fetch_article_languages(@healthwise_article.hwid)
      # fetch article's JSON from hwid for [languages], otherwise default to english
      @healthwise_article.languages.each do |l|   # ["en-us", "vi-us"]
        response = fetch_article(@healthwise_article.hwid, l)
        @healthwise_article.send("#{CI_LOCALE[l]}_json") = response
        @healthwise_article.send("#{CI_LOCALE[l]}_title") = response["data"]["title"]["consumer"]
      end
    else
      # fetch topic for available languages
    end

    # save
    respond_to do |format|
      if @healthwise_article.save
        format.html { redirect_to @healthwise_article, notice: "Healthwise article was successfully created." }
        format.json { render :show, status: :created, location: @healthwise_article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @healthwise_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /healthwise_articles/1 or /healthwise_articles/1.json
  def update
    respond_to do |format|
      if @healthwise_article.update(healthwise_article_params)
        format.html { redirect_to @healthwise_article, notice: "Healthwise article was successfully updated." }
        format.json { render :show, status: :ok, location: @healthwise_article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @healthwise_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /healthwise_articles/1 or /healthwise_articles/1.json
  def destroy
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
      "zh-us" => "zh_cn",
      "en-us" => "en"
    }

    HW_LOCALE = {
      "vi"  => "vi-us",
      "hmn" => "hm-us",
      "zh-tw" => "zh-us",
      "zh-cn" => "zh-us",
      "en" => "en-us"
    }

    LOCALES = Regexp.union(
      /en-us/i,
      /zh-us/i,
      /vi-us/i,
      /hm-us/i,
    )

    def fetch_article_languages(hwid)
      token = fetch_hw_token
      url = ENV['HEALTHWISE_CONTENT_URL'] + "/articles/#{hwid}"
      response = RestClient.get url, { "Authorization": "Bearer #{token}", "X-HW-Version": "1", "Accept": "application/json"}
      # iterate over json hash to match for available locales #
      languages = []
      response['links']['localizations'].map {l| languages << l.key if l.match(LOCALES)}
      logger.warn("#{languages}")
      # return an array
      return languages.uniq
    end

    def fetch_article(hwid, language)
      token = fetch_hw_token
      url = ENV['HEALTHWISE_CONTENT_URL'] + "/articles/#{hwid}/#{language}"
      response = RestClient.get url, { "Authorization": "Bearer #{token}", "X-HW-Version": "1", "Accept": "application/json"}
    end

    def fetch_topic_languages(topic)
      token = fetch_hw_token
      url = ENV['HEALTHWISE_CONTENT_URL'] + "/topics/#{topic.hwid}"
      response = RestClient.get url, { "Authorization": "Bearer #{token}", "X-HW-Version": "1", "Accept": "application/json"}
    end

    def fetch_topic(topic, language)
      token = fetch_hw_token
      url = ENV['HEALTHWISE_CONTENT_URL'] + "/topics/#{topic.hwid}/#{language}?contentOutput=html+json"
      response = RestClient.get url, { "Authorization": "Bearer #{token}", "X-HW-Version": "1", "Accept": "application/json"}
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_healthwise_article
      @healthwise_article = HealthwiseArticle.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def healthwise_article_params
      params.require(:healthwise_article).permit(:hwid, :type, :en_title, :en_json, :en_translated, :zh_tw_title, :zh_tw_json, :zh_tw_translated, :zh_cn_title, :zh_cn_json, :zh_cn_translated, :vi_title, :vi_json, :vi_translated, :hmn_title, :hmn_json, :hmn_translated, :category, :featured, :archive, :languages)
    end
end
