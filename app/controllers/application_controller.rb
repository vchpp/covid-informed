class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token, :only => :create
  protect_from_forgery prepend: true
  before_action :set_locale, :count_visits, :set_visitor

private

  def authenticate_admin!
    authenticate_user!
    redirect_to root_path unless current_user.try(:admin?)
  end

  def count_visits
    value = (cookies[:visits] || 0 ).to_i
    cookies[:visits] = (value + 1).to_s
    # @visits = cookies[:visits]
  end

  def set_visitor
    if request.query_parameters[1..200]
      cookies[:rct] ||= {
        value: request.query_parameters['rct'],
        path: '/',
        SameSite: 'Lax'
      }
    else
      cookies[:rct] ||= {
        value: rand(10000..99999),
        path: '/',
        SameSite: 'Lax'
      }
    end
  end

  # sets the locale language within the route
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
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
end
