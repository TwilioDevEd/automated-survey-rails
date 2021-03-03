Rails.application.routes.draw do
  root 'surveys#index'
  post 'surveys/voice', to: 'surveys#voice'
  post 'surveys/sms', to: 'surveys#sms'

  resources :questions, only: [:show]
  resources :answers, only: [:create]
  resources :transcriptions, only: [:create]
end
