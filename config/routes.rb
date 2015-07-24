Rails.application.routes.draw do
	resources :subjects
	root "home#index"

	get "/home", to: "home#index", as: "home"

	resources :questions

	get "/data_imports/models", to: "data_imports#models"
	resources :data_imports do 
		new { put :update }
	end



end
