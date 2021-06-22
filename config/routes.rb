Rails.application.routes.draw do
  scope "(:locale)", locale: /en|zh_CN|zh_TW|hmn|vi/ do
    resources :messages do
      resources :likes
      resources :comments do
        resources :votes
      end
    end
    devise_for :users

    get '/admin', to: 'admin#index'
    get '/resources', to: 'resources#index'
    get '/about', to: 'about#index'
    root 'about#index'

    direct :rails_public_blob do |blob|
      # Preserve the behaviour of `rails_blob_url` inside these environments
      # where S3 or the CDN might not be configured
      if Rails.env.development? || Rails.env.test?
        route_for(:rails_blob, blob)
      else
        # Use an environment variable instead of hard-coding the CDN host
        # You could also use the Rails.configuration to achieve the same
        File.join(ENV.fetch("CDN_HOST"), blob.key)
      end
    end
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end
end
