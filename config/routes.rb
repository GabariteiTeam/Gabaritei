Rails.application.routes.draw do

	root "home#index"

	get "/home", to: "home#index", as: "home"

	# SUBJECTS ROUTES

	get "/subjects/", to: "subjects#index", as: "subjects_home"
	get "/subjects/:id", to: "subjects#show", as: "read_subject"
	post "/subjects/", to: "subjects#create", as: "subjects_new"
	put "/subjects/", to: "subjects#update", as: "subjects_update"
	delete "/subjects/:id", to: "subjects#destroy", as: "subjects_delete"

	# END SUBJECTS ROUTES

	# QUESTIONS ROUTES

	get "/questions", to: "questions#index"
	get "/questions/:id", to: "questions#show"
	post "/questions/", to: "questions#create"
	delete "/questions/:id", to: "questions#destroy"

	# END QUESTIONS ROUTES

	# DATA IMPORT ROUTES

	resources :data_imports do
		put :import, on: :member
		get :models, on: :collection
	end

	# END DATA IMPORT ROUTES

	# TRANSLATIONS ROUTES

	resources :translations, only: :show

	# END TRANSLATIONS ROUTES

end
