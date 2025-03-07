Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :post_comments, only: [:create,:destroy]
    resource :favorites, only: [:create,:destroy]
  end
  resources :users, only: [:index,:show,:edit,:update]
  


  root to: "homes#top"
  get "home/about"=>"homes#about",as: 'about'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

