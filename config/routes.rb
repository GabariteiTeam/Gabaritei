Rails.application.routes.draw do
	#resources :subjects

	root "home#index"

	get "/home", to: "home#index", as: "home"


	#subjects routes
	# get "/subjects/", to: "subjects#index", as: "subjects_home"
	# get "/subjects/:id", to: "subjects#show", as: "read_subject"
	# post "/subjects/", to: "subjects#create", as: "subjects_new"
	# put "/subjects/", to: "subjects#update", as: "subjects_update"
	# delete "/subjects/:id", to: "subjects#destroy", as: "subjects_delete"
	resources :subjects

	resources :data_imports do
		put :import, on: :member
		get :models, on: :collection
	end



end
