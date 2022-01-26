class AdminController < ApplicationController
  before_action :authenticate_admin!, only: %i[ healthwise_article healthwise_topic ]

  def index
  end

  # move all this logic to the healthwise/application controller

  # def create
    # take params and make article.new
    # fetch article's JSON from hwid
    # save
  # end
  def healthwise_article #show
    # check if it's custom JSON
    # check if the HW JSON is out of date, then fetch_article:&update!
    @response = fetch_article
  end

  def healthwise_topic
    @response = fetch_topic
  end

private
#private methods will only run if an article needs to be updated, ie on create or show if expired


  def fetch_article
    token = fetch_healthwise_token
    url = ENV['HEALTHWISE_CONTENT_URL'] + "/articles/ack8827/#{@localization}"
    response = RestClient.get url, { "Authorization": "Bearer #{token}", "X-HW-Version": "1", "Accept": "application/json"}
  end

  def fetch_topic
    token = fetch_healthwise_token
    url = ENV['HEALTHWISE_CONTENT_URL'] + "/topics/ack9671/#{@localization}?contentOutput=html+json"
    response = RestClient.get url, { "Authorization": "Bearer #{token}", "X-HW-Version": "1", "Accept": "application/json"}
  end

end
