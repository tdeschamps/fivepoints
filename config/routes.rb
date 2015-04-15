Rails.application.routes.draw do
    
  ActiveAdmin.routes(self)
    # authenticated :user do
    #   root :to => "home#feed", :as => "authenticated_root"
    # end

    root 'home#index'
    devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
    post 'places/create_place_from_black_book' => 'places#create_place_from_black_book', as: :create_from_black_book
    resources :places, only: [:index, :show, :new, :create]

    resources :users, only: [:show, :edit, :update] do 
      resources :black_books, only: [:new, :create, :edit]
      member do
            get :following, :followers
      end
    end

    resources :black_books, only: [:show, :index] do
      resources :black_book_places, only: [:new, :create]
    end
    get 'black_books/search' => 'black_books#search', as: :search_black_books
    resources :black_book_places, only: [:show]
    resources :places, only: [:show, :index]
    resources :followships, only: [:create, :destroy]
    
    post 'black_book_places/update_position' => 'black_book_places#update_position'
    post 'black_book_places/:id/send_to_archive' => 'black_book_places#send_to_archive', as: :archive
    post 'black_books/:id/upvote' => 'black_books#upvote', as: :upvote_black_book
    post 'black_books/:id/downvote' => 'black_books#downvote', as: :downvote_black_book
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
