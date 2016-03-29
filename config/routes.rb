Rails.application.routes.draw do
  post 'voice/connect' => 'voice#connect'
end
