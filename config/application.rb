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
  end
end
