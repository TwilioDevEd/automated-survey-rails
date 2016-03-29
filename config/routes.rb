Rails.application.routes.draw do
  post 'voice/connect' => 'voice#connect'

  resources :questions, only: [:show]
end
