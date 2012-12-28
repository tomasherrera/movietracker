Movietracker::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users

  resources :movies, only: [:index, :show] do
    resources :checkins, only: [:create, :destroy]
  end

  root to: "movies#index"

  get 'watchlist', to: 'user_movies#index', as: :watchlist
  get 'tags/:tag', to: 'movies#index', as: :tag
end
