C4::Application.routes.draw do
  get 'sessions/help' => 'sessions#help', :as => 'help'  
  resources :games, :sessions
  root to: 'games#index'
end
