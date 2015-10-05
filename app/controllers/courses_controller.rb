class CoursesController < ApplicationController
  
	# GET /data_import.json
    def index
		@courses = Course.all
		render json: @courses, methods: [:subject, :field]
	end

	# File upload
	def create
		@course = Course.new(course_params)
		@course.category = category_params.has_key?(:field_id) && category_params[:field_id] != nil ? Field.find(category_params[:field_id]) : Subject.find(category_params[:subject_id])
		if @course.save
	      render json: {success: true}
	    else
	      render json: @course.errors, status: :unprocessable_entity
	    end  
	end

	def show
    	@course = Course.find(params[:id])
    	render json: @course, methods: [:category, :users_info]
  	end

	def update
		@course = Course.find(course_params[:id])
		@course.category = category_params.has_key?(:field_id) && category_params[:field_id] != nil ? Field.find(category_params[:field_id]) : Subject.find(category_params[:subject_id])
		if @course.update(course_params)
	      render json: {success: true}
	    else
	      render json: @course.errors, status: :unprocessable_entity
	    end 
	end

	def destroy
		Course.find(params[:id]).destroy
		render json: {success: true}
	end

	private 

	    def course_params
	    	params.require(:course).permit(:id, :name, :description)
	    end

	    def category_params
	    	params.permit(:subject_id, :field_id)
	    end

end