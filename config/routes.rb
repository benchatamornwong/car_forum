CarForum::Application.routes.draw do
  resources :post_attachments

  resources :users
  resources :sessions,  only: [:new, :create, :destroy]
  resources :boards do
    resources :posts 
  end
  resources :posts do
    resources :comments
  end

  root  'static_pages#home'
  match '/signup',    to: 'users#new',            via: 'get'
  match '/signin',    to: 'sessions#new',         via: 'get'
  match '/signout',   to: 'sessions#destroy',     via: 'delete'
  match 'tags/:tag',  to: 'posts#index',          via: 'get' ,  as: :tag
  match '/search',    to: 'posts#search',         via: 'get'
  match '/users',     to: 'users#search',         via: 'get'
  match '/users/:id/admin', to: 'users#admin',    via: 'post'
  match '/tags',      to: 'static_pages#tags',    via: 'get'
  match '/posts/:id/upvote', to: 'posts#upvote',  via: 'post'
  match '/posts/:id/downvote', to: 'posts#downvote', via: 'post'
  match '/comments/:id/upvote', to: 'comments#upvote', via: 'post'
  match '/comments/:id/downvote', to: 'comments#downvote', via: 'post'
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
