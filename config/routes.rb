Rails.application.routes.draw do
	resources :subjects
	root "home#index"

	get "/home", to: "home#index", as: "home"

	resources :questions

	post "/data_import/upload", to: "data_import#upload"
	post "/data_import/import", to: "data_import#import"
	get "/data_import", to: "data_import#index"

end
