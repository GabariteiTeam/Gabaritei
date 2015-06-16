Rails.application.routes.draw do
	resources :subjects
	root "home#index"

	get "/home", to: "home#index", as: "home"

	resources :questions
	resources :questions do
		collection do
			get 'getQuestionsSubject/:id' => "questions#getQuestionsSubject"
		end
	end
end
