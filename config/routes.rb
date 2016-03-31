Rails.application.routes.draw do
  post 'surveys/voice' => 'surveys#voice'

  resources :questions, only: [:show]
  resources :answers, only: [:create]
end
