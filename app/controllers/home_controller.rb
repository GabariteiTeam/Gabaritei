class HomeController < ApplicationController
  
  def index
  	courses = current_user.courses
  	courses.each do |course|
		course.current_user = current_user
	end
  	render json: {
  		courses: courses.as_json(include: {lessons: {methods: [:updated_at_string]}}, methods: [:category_description, :teachers, :user_recommendations])
  	}
  end
    
end
