Rails.application.routes.draw do
	resources :subjects
	root "home#index"

	get "/home", to: "home#index", as: "home"

	resources :questions

end
