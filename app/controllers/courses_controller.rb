class CoursesController < ApplicationController

	before_action :verify_permissions, except: [:index]
  
    def index    	
		c = Course.all
		c.each do |course|
			course.current_user = current_user
		end
		render json: c, methods: [:subject, :field, :avatar_url_thumb, :has_user]
	end

	def create
		if @permissions['permission.courses.globally_manipulate']
			course = Course.new(course_params)
			if course.save
		      	render json: {success: true}
		    else
		      	render json: course.errors, status: :unprocessable_entity
		    end
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	def show
		course = Course.find(params[:id])
		render json: course, methods: [:category, :users_info, :has_avatar, :avatar, :avatar_url_medium]
  	end

	def update
		course = Course.find(course_params[:id])
		if @permissions['permission.courses.globally_manipulate'] || @permissions['permission.courses.manipulate'] && course.has_user(current_user)
			if course_params[:avatar] == "null"
				course.avatar = nil
				params.delete :avatar
			end
			if course.update(course_params)
		      	render json: {success: true}
		    else
		      	render json: course.errors, status: :unprocessable_entity
		    end
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	def destroy
		if @permissions['permission.courses.globally_manipulate']
			Course.find(params[:id]).destroy
			render json: {success: true}
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	def search_users
		course = Course.find(search_user_params[:id])
		if @permissions['permission.courses.globally_manipulate'] || @permissions['permission.courses.manipulate'] && course.has_user(current_user)
			@users = User.includes(:courses).where("users.role_id = :role_id AND (users.first_name LIKE :search_string OR users.last_name LIKE :search_string OR users.email LIKE :search_string) AND NOT EXISTS (SELECT * FROM user_courses WHERE user_courses.user_id = users.id AND user_courses.course_id = :course_id)", {role_id: search_user_params[:role_id], search_string: "%#{search_user_params[:search_string]}%", course_id: search_user_params[:id]})
			render json: @users, methods: [:avatar_url_thumb]
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	def add_participants
		course = Course.find(params[:id])
		if @permissions['permission.courses.globally_manipulate'] || @permissions['permission.courses.manipulate'] && course.has_user(current_user)
			users = course.users.to_a
			params[:participants].each do |participant|
				user = User.find(participant[:id])
				users.push(user)
			end
			course.users = users.uniq
			if course.save
		      	render json: {success: true}
		    else
		      	render json: course.errors, status: :unprocessable_entity
		    end
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	def remove_participant
		course = Course.find(params[:id])
		if @permissions['permission.courses.globally_manipulate'] || @permissions['permission.courses.manipulate'] && course.has_user(current_user)
			users = course.users.to_a
			users.delete_if {|user| user.id == params[:user_id].to_i}
			course.users = users
			if course.save
		      	render json: {success: true}
		    else
		      	render json: course.errors, status: :unprocessable_entity
		    end 
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	def show_everything
		course = Course.find(params[:id])
		if @permissions['permission.courses.globally_manipulate'] || course.has_user(current_user) && (@permissions['permission.courses.manipulate'] || @permissions['permission.courses.teach'] || @permissions['permission.courses.take_part'])
			render json: course, include: {lessons: {methods: [:timeline]}}, methods: [:subject, :field, :course_news, :teachers, :avatar_url_medium]
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	def add_lesson
		if @permissions['permission.courses.globally_manipulate'] || @permissions['permission.courses.teach']
			course = Course.find(params[:id])
			lesson = Lesson.new
			lesson.course = course
			lesson.title = lesson_params[:title]
			lesson.description = lesson_params[:description]
			if lesson_params[:contents] != nil
				lesson_params[:contents].each do |content_id|
					content = Content.find(content_id)
					lesson.contents.push(content)
				end
			end
			if lesson_params[:questions] != nil
				lesson_params[:questions].each do |question_id|
					question = Question.find(question_id)
					lesson.questions.push(question)
				end
			end
			if lesson.save!
				render json: {success: true}
			else
				render json: lesson.errors, status: :unprocessable_entity
			end
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	def edit_lesson
		if @permissions['permission.courses.globally_manipulate'] || @permissions['permission.courses.teach']
			lesson = Lesson.find(lesson_params[:id])
			lesson.title = lesson_params[:title]
			lesson.description = lesson_params[:description]
			contents = []
			questions = []
			if lesson_params[:contents] != nil
				lesson_params[:contents].each do |content_id|
					content = Content.find(content_id)
					contents.push(content)
				end
			end
			if lesson_params[:questions] != nil
				lesson_params[:questions].each do |question_id|
					question = Question.find(question_id)
					questions.push(question)
				end
			end
			lesson.contents = contents
			lesson.questions = questions
			if lesson.save!
				render json: {success: true}
			else
				render json: lesson.errors, status: :unprocessable_entity
			end
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	def get_lesson
		course = Course.find(params[:id])
		if @permissions['permission.courses.globally_manipulate'] || @permissions['permission.courses.teach']
			lesson = Lesson.find(params[:lesson_id])
			render json: lesson
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	def delete_lesson
		course = Course.find(params[:id])
		if @permissions['permission.courses.globally_manipulate'] || @permissions['permission.courses.teach']
			lesson = Lesson.find(params[:lesson_id])
			if lesson.destroy!
				render json: {success: true}
			else
				render json: lesson.errors, status: :unprocessable_entity
			end
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	def courses_for_test
		if @permissions['permission.courses.globally_manipulate']
			courses = Course.all
			render json: courses
		elsif @permissions['permission.courses.teach']
			courses = current_user.courses
			render json: courses
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	private 

	    def course_params
	    	params.permit(:id, :name, :description, :category_id, :category_type, :avatar)
	    end

	    def search_user_params
	    	params.permit(:id, :role_id, :search_string)
	    end

	    def lesson_params
	    	params.require(:lesson).permit(:id, :course_id, :title, :description, :contents => [], :questions => [])
	    end

	    def verify_permissions
	    	@permissions = current_user.verify_permissions(['permission.courses.globally_manipulate', 'permission.courses.manipulate', 'permission.courses.teach', 'permission.courses.take_part'])
	    end

end