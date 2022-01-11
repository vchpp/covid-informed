require_relative "boot"

require "rails/all"
require 'csv'
require "logger"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Informed
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.i18n.available_locales = [:en, :zh_CN, :zh_TW, :hmn, :vi]
    config.i18n.default_locale = :en
    config.i18n.fallbacks = [:en]

    config.logger = Logger.new("log/#{Rails.env}.log")
    config.logger.datetime_format = "%Y-%m-%d %H:%M:%S"
    # config.logger.auto_flushing = true
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # set request.remote_ip proxy IPs for Cloudflare
    check_spoofing = true
    proxies = ["173.245.48.0/20",
"103.21.244.0/22",
"103.22.200.0/22",
"103.31.4.0/22",
"141.101.64.0/18",
"108.162.192.0/18",
"190.93.240.0/20",
"188.114.96.0/20",
"197.234.240.0/22",
"198.41.128.0/17",
"162.158.0.0/15",
"104.16.0.0/13",
"104.24.0.0/14",
"172.64.0.0/13",
"131.0.72.0/22",
"2400:cb00::/32",
"2606:4700::/32",
"2803:f800::/32",
"2405:b500::/32",
"2405:8100::/32",
"2a06:98c0::/29",
"2c0f:f248::/32"]
    proxies += ActionDispatch::RemoteIp::TRUSTED_PROXIES
    config.middleware.swap ActionDispatch::RemoteIp,
                           ActionDispatch::RemoteIp,
                           true,
                           proxies
  end
end
