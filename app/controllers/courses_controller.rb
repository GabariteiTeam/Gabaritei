class CoursesController < ApplicationController
  
    def index    	
		@courses = Course.all
		render json: @courses, methods: [:subject, :field, :avatar_url_thumb]
	end

	# File upload
	def create
		@course = Course.new(course_params)
		if @course.save
	      	render json: {success: true}
	    else
	      	render json: @course.errors, status: :unprocessable_entity
	    end  
	end

	def show
    	@course = Course.find(params[:id])
    	render json: @course, methods: [:category, :users_info, :has_avatar, :avatar, :avatar_url_medium]
  	end

	def update
		@course = Course.find(course_params[:id])
		if course_params[:avatar] == "null"
			@course.avatar = nil
			params.delete :avatar
		end
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

	def search_users
		@users = User.includes(:courses).where("users.role_id = :role_id AND (users.first_name LIKE :search_string OR users.last_name LIKE :search_string OR users.email LIKE :search_string) AND NOT EXISTS (SELECT * FROM user_courses WHERE user_courses.user_id = users.id AND user_courses.course_id = :course_id)", {role_id: search_user_params[:role_id], search_string: "%#{search_user_params[:search_string]}%", course_id: search_user_params[:id]})
		render json: @users, methods: [:avatar_url_thumb]
	end

	def add_participants
		@course = Course.find(params[:id])
		users = @course.users.to_a
		params[:participants].each do |participant|
			user = User.find(participant[:id])
			users.push(user)
		end
		@course.users = users.uniq
		if @course.save
	      	render json: {success: true}
	    else
	      	render json: @course.errors, status: :unprocessable_entity
	    end 
	end

	def remove_participant
		@course = Course.find(params[:id])
		users = @course.users.to_a
		users.delete_if {|user| user.id == params[:user_id].to_i}
		@course.users = users
		if @course.save
	      	render json: {success: true}
	    else
	      	render json: @course.errors, status: :unprocessable_entity
	    end 
	end

	def show_everything
		course = Course.find(params[:id])
		render json: course, include: {lessons: {methods: [:timeline]}}, methods: [:subject, :field, :course_news, :tests, :teachers, :avatar_url_medium]
	end

	def add_lesson
		course = Course.find(params[:id])
		lesson = Lesson.new
		lesson.course = course
		lesson.title = params[:lesson][:name]
		lesson.description = params[:lesson][:description]
		if params[:lesson][:contents] != nil
			params[:lesson][:contents].each do |content_id|
				content = Content.find(content_id)
				lesson.contents.push(content)
			end
		end
		if params[:lesson][:questions] != nil
			params[:lesson][:questions].each do |question_id|
				question = Question.find(question_id)
				lesson.questions.push(question)
			end
		end
		if lesson.save!
			render json: {success: true}
		else
			render json: lesson.errors, status: :unprocessable_entity
		end
	end

	private 

	    def course_params
	    	params.permit(:id, :name, :description, :category_id, :category_type, :avatar)
	    end

	    def search_user_params
	    	params.permit(:id, :role_id, :search_string)
	    end

end