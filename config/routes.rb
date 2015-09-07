Rails.application.routes.draw do

	root "templates#home"

	get "/home", to: "home#index", as: "home"

	# SUBJECTS ROUTES

	get "/subjects/", to: "subjects#index", as: "subjects_home"
	get "/subjects/:id", to: "subjects#show", as: "read_subject"
	get "/subjects/validate/destroy/:id", to: "subjects#validate_destroy"
	post "/subjects/", to: "subjects#create", as: "subjects_new"
	put "/subjects/", to: "subjects#update", as: "subjects_update"
	delete "/subjects/:id", to: "subjects#destroy", as: "subjects_delete"

	# END SUBJECTS ROUTES

	# QUESTIONS ROUTES

	get "/questions", to: "questions#index"
	get "/questions/:id", to: "questions#show"
	put "/questions", to: "questions#customUpdate"
	post "/questions/", to: "questions#create"
	delete "/questions/:id", to: "questions#destroy"

	# END QUESTIONS ROUTES

	# USERS ROUTES

	resources :users

	# END USERS ROUTES

	# DATA IMPORT ROUTES

	resources :data_imports do
		put :import, on: :member
	end

	# END DATA IMPORT ROUTES

	# ROLES AND PERMISSIONS ROUTES

	resources :roles do
		get "validate/destroy", to: "roles#validate_destroy", on: :member
	end
	resources :permissions, only: :index

	# END ROLES AND PERMISSIONS ROUTES

	# TRANSLATIONS ROUTES

	resources :translations, only: :show

	# END TRANSLATIONS ROUTES

	# TEMPLATES ROUTES

	get "templates/*path", to: "templates#serve"

	# END TEMPLATES ROUTES

end
