C4::Application.routes.draw do
  resources :games
  root to: 'games#index'
end
