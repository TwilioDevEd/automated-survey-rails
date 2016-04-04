Rails.application.routes.draw do
  root 'surveys#index'
  post 'surveys/voice' => 'surveys#voice'
  post 'surveys/sms' => 'surveys#sms'

  resources :questions, only: [:show]
  resources :answers, only: [:create]
  resources :transcriptions, only: [:create]
end
