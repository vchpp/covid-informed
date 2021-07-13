Rails.application.routes.draw do
  scope "(:locale)", locale: /en|zh_CN|zh_TW|hmn|vi/ do
    resources :profiles
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
    scope '/resources' do
      resources :faqs
    end
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end
end
