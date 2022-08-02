class HealthwiseArticlesController < ApplicationController
  before_action :set_healthwise_article, only: %i[ show edit update upgrade refresh destroy ]
  before_action :authenticate_admin!, only: %i[ new create edit update upgrade refresh destroy ]
  before_action :set_page, only: [:show]

  # GET /healthwise_articles or /healthwise_articles.json
  def index
    @healthwise_articles = HealthwiseArticle.where(nil).order('en_title ASC') # creates an anonymous scope
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
    # logger.warn fetch_hw_token
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
    respond_to do |format|
      format.html
      format.csv do
        if (params[:format_data] == 'comments')
          send_data @healthwise_article.comments_to_csv, filename: "HealthwiseArticle##{@healthwise_article.id}-Comments-#{Date.today}.csv"
        elsif (params[:format_data] == 'likes')
          send_data @healthwise_article.likes_to_csv, filename: "HealthwiseArticle##{@healthwise_article.id}-Likes-#{Date.today}.csv"
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
      @healthwise_article.send("#{CI_LOCALE[l]}_json=".downcase,JSON.parse(response))
      # set titles
      if @healthwise_article.article_or_topic == "Article"
        @healthwise_article.send("#{CI_LOCALE[l]}_title=".downcase, JSON.parse(response)["data"]["title"]["consumer"])
      else
        @healthwise_article.send("#{CI_LOCALE[l]}_title=".downcase, JSON.parse(response)["data"]["topics"][0]["title"]["consumer"])
      end
    end

    # compare @healthwise_article.languages against CI_LOCALE to find missing languages
    # overwrite english title and json onto missing languages
    # backfill_english_json

    # custom translations
      # # iterate over CI_LOCALE hash and for any response that returns a 404, turn it into a stub
      # fetch article for available languages, store them in @healthwise_article.languages
      # @healthwise_article.languages = fetch_languages(@healthwise_article.article_or_topic, @healthwise_article.hwid)
      # CI_LOCALE.each do |k,v|
      #   response = fetch_article(@healthwise_article.article_or_topic, @healthwise_article.hwid, k)
      #   if response == nil
      #     # create JSON stubs
      #     if @healthwise_article.article_or_topic == "Article"
      #       # needs Article JSON stub
      #       # @healthwise_article.send("#{v}_json=".downcase, {data: {topics: [{html: ""}]}})
      #     else
      #       @healthwise_article.send("#{v}_json=".downcase, {data: {topics: [{html: ""}]}}) # ["data"]["topics"][0]["html"] or '{'data':{'topics':[{'html':''}]}}'
      #     end
      #     @healthwise_article.send("#{v}_translated=".downcase, true)
      #   else
      #     @healthwise_article.send("#{v}_json=".downcase, JSON.parse(response))
      #     # set titles
      #     if @healthwise_article.article_or_topic == "Article"
      #       @healthwise_article.send("#{v}_title=".downcase, JSON.parse(response)["data"]["title"]["consumer"])
      #     else
      #       @healthwise_article.send("#{v}_title=".downcase, JSON.parse(response)["data"]["topics"][0]["title"]["consumer"])
      #     end
      #   end
      # end
    @healthwise_article.zh_cn_json = @healthwise_article.zh_tw_json
    @healthwise_article.zh_cn_title = @healthwise_article.zh_tw_title
      # custom translations
      # @healthwise_article.zh_cn_translated = @healthwise_article.zh_tw_translated
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
    # add logic here to check if the `translated: true` fields are populated or empty
    # HW_LOCALE.each do |k,v|
    #   if @healthwise_article.send("#{k}_translated".downcase) == true
    #     # logger.warn("#{params[:hmn_json]}")
    #     # check if the hash datastructre already exists to prevent nested hash from being created
    #     if params[:"#{k}_json"].present?
    #       # if populated, add content `_json['data']['topics'][0]['html']`
    #       @healthwise_article.send("#{k}_json=".downcase)['data']['topics'][0]['html'].update(params[:"#{k}_json"]['data']['topics'][0]['html'])
    #     end
    #   end
    # end
    # then
    @healthwise_article.en_json.to_h
    @healthwise_article.zh_tw_json.to_h
    @healthwise_article.zh_cn_json.to_h
    @healthwise_article.vi_json.to_h
    @healthwise_article.hmn_json.to_h
    @healthwise_article[:languages] = params[:healthwise_article][:languages].first.split("\r\n").map(&:strip)
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
      end
    end

    # save simplified chinese with traditional chinese's values
    @healthwise_article.zh_cn_json = @healthwise_article.zh_tw_json if @healthwise_article.zh_tw_json.present?

    redirect_to @healthwise_article, notice: "Healthwise article was successfully refreshed from the HW API."
    logger.info "#{current_user.email} refreshed Healthwise #{@healthwise_article.id} with title #{@healthwise_article.en_title}"
    audit! :refreshed_healthwise_article, @healthwise_article, payload: @healthwise_article.attributes
  end

  def upgrade
    backfill_english_json
    respond_to do |format|
      if @healthwise_article.update(healthwise_article_params) # breaks here due to missing params? params.require(:healthwise_article)
        format.html { redirect_to @healthwise_article, notice: "Healthwise article was successfully upgraded to custom translations." }
        format.json { render :show, status: :ok, location: @healthwise_article }
        logger.info "#{current_user.email} upograded Healthwise #{@healthwise_article.id} with title #{@healthwise_article.en_title}"
        audit! :upgraded_healthwise_article, @healthwise_article, payload: @healthwise_article.attributes
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @healthwise_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /healthwise_articles/1 or /healthwise_articles/1.json
  def destroy
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

    def backfill_english_json # used in create/upgrade
      # compare @healthwise_article.languages against CI_LOCALE to find missing languages
      # overwrite english title and json onto missing languages

    end

    # Use callbacks to share common setup or constraints between actions.
    def set_healthwise_article
      @healthwise_article = HealthwiseArticle.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def healthwise_article_params
      params.require(:healthwise_article).permit(:hwid, :article_or_topic, :en_title, :en_json, :en_translated, :zh_tw_title, :zh_tw_json, :zh_tw_translated, :zh_cn_title, :zh_cn_json, :zh_cn_translated, :vi_title, :vi_json, :vi_translated, :hmn_title, :hmn_json, :hmn_translated, :en_rich_text, :zh_tw_rich_text, :zh_cn_rich_text, :vi_rich_text, :hmn_rich_text, :category, :featured, :archive, :languages)
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
