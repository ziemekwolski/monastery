Rails.application.routes.draw do

  scope "(:locale)", locale: /#{Idioma.conf.locales.join("|")}/ do
    root 'pages#home'
    resources :posts, only: [:index, :show]
    resources :categories, only: [:index, :show]

    get 'robots', to: 'pages#robots', as: :robots

    # Logging in/out
    get 'login',  to: 'user_sessions#new',     as: :login
    post 'login', to: 'user_sessions#create'
    get 'logout', to: 'user_sessions#destroy', as: :logout

    namespace :admin do
      root 'posts#index'
      resources :posts, except: [:show]
      resources :categories, except: [:show]
      resources :users, except: [:show]
      resources :uploads, only: [:index, :show, :update, :create]
      resources :settings, only: [:index, :edit, :update]
      mount Idioma::Engine => "/idioma"
    end

    get "/:id", to: "posts#show", as: :page
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
