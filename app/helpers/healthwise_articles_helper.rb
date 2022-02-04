module HealthwiseArticlesHelper

  def article_locale
    if @healthwise_article.send("#{params[:locale]}_json".downcase).present?
      params[:locale]
    else
      flash[:notice] = "Unfortunately this language is not available at this time.  Please check back at another time."
      "en"
    end
  end
end
