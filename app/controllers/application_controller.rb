class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token, :only => :create
  protect_from_forgery prepend: true
  before_action :set_locale, :count_visits, :set_admin, :set_visitor

private

  def authenticate_admin!
    redirect_to root_path unless current_user.try(:admin?)
  end

  def count_visits
    value = (cookies[:visits] || 0 ).to_i
    cookies[:visits] = (value + 1).to_s
    # @visits = cookies[:visits]
  end

  def set_admin
    if current_user.try(:admin?)
      cookies[:rct] = 0
    end
  end

  def set_visitor
    if params[:rct].to_i.between?(1,9999)
      cookies[:rct] = {
        value: params[:rct],
        path: '/',
        SameSite: 'none',
        secure: 'true'
      }
    else
      cookies[:rct] ||= {
        value: rand(10000..99999999),
        path: '/',
        SameSite: 'none',
        secure: 'true'
      }
    end
  end

  # sets the locale language within the route
  def set_locale
    I18n.locale = params[:locale] || request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/)[0] || I18n.default_locale
  end

  # allows for the router to add /language/ as a default route
  def default_url_options
    { locale: I18n.locale }
  end

  # pulls "accept-language" header and automatically finds locale
  def extract_locale
    parsed_locale = params[:locale] || request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/)[0]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : 'en'
  end


  require "rest-client"

  def fetch_hw_token
    Rails.cache.fetch("/healthwise_api_token", expires_in: 1.day) do
      url = ENV['HEALTHWISE_AUTH_URL'] + "/oauth2/token"
      response = RestClient::Request.execute(
        method: :post,
        url: url,
        user: ENV['HEALTHWISE_CLIENT_ID'],
        password: ENV['HEALTHWISE_CLIENT_SECRET'],
        payload: "grant_type=client_credentials&scope=*"
      )
      JSON.parse(response.body)["access_token"]
    end
  end
end
