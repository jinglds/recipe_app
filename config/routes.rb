RecipeApp::Application.routes.draw do
  resources :users do
    resources :favorites, only: [:index, :create, :destroy]
    member do
      get :following, :followers
    end    
  end
  resources :sessions,      only: [:new, :create, :destroy]
  resources :microposts,    only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :recipes do
    resources :comments, only: [:create, :destroy] do
      member do
        put "like", to: "comments#upvote"
        put "dislike", to: "comments#downvote"
      end
    end
    member do
      put "like", to: "recipes#upvote"
      put "dislike", to: "recipes#downvote"
    end
    collection do
      match 'search' => 'recipes#search', via: [:get, :post], as: :search
    end
end
  
  root  'static_pages#home'
  match '/favorites', to: 'users#favorites',  via: 'get'
  match '/feed_index', to: 'recipes#feed_index',          via: 'get'
  match '/index', to: 'recipes#index',          via: 'get'
  match '/newrecipe',  to: 'recipes#new',       via: 'get'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'

  get 'tags/:tag', to: 'recipes#index', as: :tag

  match "recipes/:id/feature" => "recipes#feature", via: [:get, :post], :as => "feature_recipe"
  match "recipes/:id/unfeature" => "recipes#unfeature", via: [:get, :post], :as => "unfeature_recipe"








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
