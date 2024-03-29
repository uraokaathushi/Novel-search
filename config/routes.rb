Rails.application.routes.draw do

  # devise_for :genres_selects
  # devise_for :genres
  # devise_for :favorites
  # devise_for :comments
  # devise_for :novels
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

 get  '/admin', to: 'admin/homes#top', as: "admin"
 namespace :admin do
    resources :novels, only: [:index, :show, :edit, :update, :destroy] do
     member do
      delete 'destroy_review'
      end
    end
    resources :genres, only: [:create, :index, :edit, :update, :destroy]
    resources :customers, only: [:index, :show, :edit, :update,]
   end
  patch '/admin/customers/withdraw', to: 'admin/customers#withdraw', as: 'admin_withdraw'

  root 'public/homes#top'

  get  '/about', to: 'public/homes#about', as: "about"

 namespace :public do
    resources :novels, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
     resources :comments, only: [:create, :destroy]
   end
    # resources :favorites, only: [:create, :destroy, :index]
   get 'genres_select', to: 'genres_select#genres_select', as: 'genres_select'
   get 'genres_search', to: 'search#search', as: 'genres_search'
   get '/my_novels' =>'customers#my_novel', as: 'my_novels'
   get '/customers/information/edit' => 'customers#edit', as: 'edit_customer'
   get '/customers/my_page' => 'customers#show', as: 'customer_my_page'
   patch '/customers/information' => 'customers#update', as: 'information'
   get '/customers/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe_customer'
   patch '/customers/withdraw' => 'customers#withdraw', as: 'withdraw_customer'
  end

devise_scope :customer do
  post '/guest_login' => 'public/sessions#guest_login', as: 'customer_guest_sign_in'
end




end

