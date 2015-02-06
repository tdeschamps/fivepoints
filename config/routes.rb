Rails.application.routes.draw do
    
    # authenticated :user do
    #   root :to => "home#feed", :as => "authenticated_root"
    # end

    root 'home#index'
    devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
    post 'places/create_place_from_city_guide' => 'places#create_place_from_city_guide'
    resources :places, only: [:index, :show, :new, :create]

    resources :users do 
      resources :city_guides, only: [:new, :create, :edit]
    end

    resources :city_guides, only: [:show, :index]
    
    resources :city_guides do
      resources :city_guide_places, only: [:new, :create]
    end

    resources :city_guide_places, only: [:show]
    
    post 'city_guide_places/update_rank'=> 'city_guide_places#update_rank'


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
