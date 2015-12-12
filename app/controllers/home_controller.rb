class HomeController < ApplicationController
  
  def index
  	courses = current_user.courses
  	render json: {
  		courses: courses.as_json(include: {lessons: {methods: [:updated_at_string]}}, methods: [:category_description, :teachers])
  	}
  end
    
end
