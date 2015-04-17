Rails.application.routes.draw do
  resources :subjects

  root "home#index"
  resources :questions
end
