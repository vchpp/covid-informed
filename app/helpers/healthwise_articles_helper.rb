module HealthwiseArticlesHelper

  def article_locale
    if @healthwise_article.send("#{params[:locale]}_json".downcase).present?
      params[:locale].downcase
    else
      flash.now[:alert] = "Unfortunately this language is not available at this time.  Please check back at another time. (t)"
      "en"
    end
  end
end
