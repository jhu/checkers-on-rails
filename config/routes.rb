CheckersApp::Application.routes.draw do
  resources :users, except: :destroy
  resources :sessions, only: [:new, :create, :destroy]
  #get 'creategame', to: 'games#create', via: 'get'
  resources :games, except: [:create, :edit] do
    member do
      get 'myturn' # myturn_game_path heartbeat
      post :play
      get :join
      get :update_match_title
      # get 'join', to: 'games#update' # join_game_path
      get 'rejoin'
      # post :test
      # get 'stream', to: 'games#stream'
      # post 'play', to: 'games#play'
    end
  end 
  #resources :move, only: [:new, :create]

  # match 'makeplay' => 'games#play', :via => :post
  # match 'makeplay',    to: 'games#play', via:'post'
  # match '/stream',   to: 'games#stream', via:'get'

  root  'static_pages#home'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'

  #match '/curl_example' => 'games#curl_get_example', via: :get
  # match '/curl_example' => 'games#curl_post_example', via: :post
  # match '/stream' => 'games#stream', via: :get

  #get 'profile', to: 'users#show'
  #resources :users, :games

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
