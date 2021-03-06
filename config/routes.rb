Rails.application.routes.draw do

  	devise_for :users

	root "templates#home"

	get "/home", to: "home#index", as: "home"

	# SUBJECTS ROUTES

	get 	"/subjects/", 		to: "subjects#index", as: "subjects_home"
	get 	"/subjects/:id", 	to: "subjects#show", as: "read_subject"
	get 	"/subjects/validate/destroy/:id", to: "subjects#validate_destroy"
	post 	"/subjects/", 		to: "subjects#create", as: "subjects_new"
	put 	"/subjects/", 		to: "subjects#update", as: "subjects_update"
	delete 	"/subjects/:id", 	to: "subjects#destroy", as: "subjects_delete"
	get 	"/subjects/fields/:id", to: "subjects#fields"

	# END SUBJECTS ROUTES

	# QUESTIONS ROUTES

	get 	"/questions", 		to: "questions#index"
	get 	"/questions/:id/show", 	to: "questions#show"
	put 	"/questions", 		to: "questions#customUpdate"
	post 	"/questions/", 		to: "questions#create"
	delete 	"/questions/:id", 	to: "questions#destroy"

	# END QUESTIONS ROUTES
	
	# FIELDS ROUTES
	post 	"/fields/", 		to: "fields#create"
	get 	"/field/:id/edit", 	to: "fields#edit"
	get 	"/fields/:id", 		to: "fields#index"
	delete 	"/fields/:id", 		to: "fields#destroy"
	put 	"/fields/", 		to: "fields#update"
	
	
	# END FIELDS ROUTES

	# RESPONSE ROUTES

	get		"/responses/:id/show", 	to: "response#show"
	get		"/responses/:id", 		to: "response#index"
	put		"/responses/",		to: "response#update"
	post		"/responses/",		to: "response#create"
	delete 		"/responses/:id",		to: "response#destroy"


	# END RESPONSE ROUTES

	# USERS ROUTES

	resources :users do
		post :verify_permissions, on: :collection
	end

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

	# COURSES ROUTES

	resources :courses do
		get :search_users, to: "courses#search_users", on: :member
		put :add_participants, to: "courses#add_participants", on: :member
		put "remove_participant/:user_id", to: "courses#remove_participant", on: :member
	end
	
	# COURSES ROUTES

	# TRANSLATIONS ROUTES

	resources :translations, only: :show

	# END TRANSLATIONS ROUTES

	# CONTENT ROUTES

	resources :contents

	# END CONTENT ROUTES

	# REQUESTS ROUTES

	resources :requests do
		get "registration", to: "requests#registration_requests", on: :collection
		post "registration", to: "requests#create_registration_request", on: :collection
		get "registration", to: "requests#get_registration_request", on: :member
		put "registration", to: "requests#assess_registration_request", on: :member
		delete "registration", to: "requests#delete_registration_request", on: :member
		get "course", to: "requests#course_registration_requests", on: :collection
		post "course", to: "requests#create_course_registration_request", on: :collection
		get "course", to: "requests#get_course_registration_request", on: :member
		put "course", to: "requests#assess_course_registration_request", on: :member
		delete "course", to: "requests#delete_course_registration_request", on: :member
	end

	# END REQUESTS ROUTES

	# TEMPLATES ROUTES

	get "templates/login", to: "templates#login"
	get "templates/*path", to: "templates#serve"

	# END TEMPLATES ROUTES

end
