C4::Application.routes.draw do
  resources :games, :sessions
  root to: 'games#index'
end
