ImmediateShare::Application.routes.draw do
  constraints(:id =>/\d+/) do
    root :to => 'share_infos#index'

    match "gate(/index)" => "gate#index", :via => :get, :as => :gate
    post "gate/login", :as => :login
    post "gate/logout", :as => :logout
    get "gate/register", :as => :register
    post "gate/create"

    scope :module => "admin" do
      scope "/admin" do
        resources :users do
          member do
            put "change_admin"
          end
        end
      end
    end

    resources :share_infos, :only => [:index, :new]

    match "share_infos/share_images/upload" => "share_infos/share_images#upload", :as=>:upload
    scope :module => "share_infos" do
      scope "/share_infos" do
        resources :share_texts, :as => :texts, :only =>[:new, :create]
        resources :share_images, :as => :images, :only => [:new, :create, :show]
        resources :share_videos, :as => :videos, :only => [:new, :create]
        resources :share_links, :as => :links, :only => [:new, :create]
      end
    end

    resources :friendships, :only => [:index, :destroy] do
      collection do
        get "search"
      end
      member do
        post "ask_for_friendship", :as => :ask
        post "agree_with_friendship", :as => :agree
      end
    end
    resources :individuals, :only => [:show, :edit, :update]
    scope :module => "individuals" do
      scope "/individuals" do
        resources :avatars, :as => :avatars, :only =>[:edit, :update, :create]
        resources :temps, :as => :temps, :only =>[:new, :create, :update], :path_names => {:new=>:crop}
      end
    end
    resources :comments, :only =>[:new, :create]
    resources :replies, :only =>[:new, :create]
    resources :system_messages, :only => [:index], :path_names => {:index => "unread"} do
      collection do
        get "all_messages", :as => :all
      end
      member do
        post "ignore"
      end
    end
  end
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
