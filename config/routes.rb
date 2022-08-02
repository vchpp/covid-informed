Rails.application.routes.draw do
  root to: redirect("/#{I18n.locale}/about/mission"), as: :redirected_root
  get '/admin', to: redirect(path: "/#{I18n.locale}/admin")
  scope "(:locale)", locale: /en|zh_CN|zh_TW|hmn|vi/ do
    resources :callouts
    resources :profiles
    resources :messages do
      resources :likes
      resources :comments do
        resources :votes
      end
    end
    devise_for :users

    get '/admin', to: 'admin#index'
    authenticate :user, -> (u) { u.admin? } do
      mount AuditLog::Engine => "/admin/audit-log"
    end
    get '/about', to: redirect("/#{I18n.locale}/about/mission")
    scope '/about' do
      get '/mission', to: 'about#index'
      get '/research-team', to: 'about#researchers'
      get '/lay-health-workers', to: 'about#lhw'
      get '/community-advisory-board', to: 'about#cabmembers'
    end
    # get '/resources', to: 'resources#index'
    get '/resources', to: redirect("/#{I18n.locale}/resources/faqs")
    scope '/resources' do
      resources :healthwise_articles, :path => '/healthwise-articles' do
        resources :likes
        resources :comments
        member do
          get :refresh
          get :upgrade
        end
      end
      resources :faqs
      resources :downloads
      resources :statistics
      resources :externals
    end
    root 'about#index'
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end
end
