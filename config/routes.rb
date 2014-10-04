Lab7::Application.routes.draw do
  
  get "sessions/index"
  root 'films#index'

  get "search/by_film"
  get "search/by_film_result"
  get "search/by_cinema"
  get "search/by_cinema_result"
  get "search/by_session"
  get "search/by_session_result"

  resources :films

  resources :cinemas

  resources :sessions
end
