Rails.application.routes.draw do
  post 'surveys/voice' => 'surveys#voice'
  post 'surveys/sms' => 'surveys#sms'

  resources :questions, only: [:show]
  resources :answers, only: [:create]
end
