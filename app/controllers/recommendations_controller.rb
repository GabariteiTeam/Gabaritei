class RecommendationsController < ApplicationController

	before_action :verify_permissions
		
	def search_users
		users = Recommendation.get_course_students(current_user.id, params[:course_id], params[:query])
		user_list = []
		users.each do |u|
			user_list.push({
				"id" => u.id,
				"name" => u.first_name + " " + u.last_name,
				"email" => u.email,
				"avatar_url" => u.avatar_url_thumb
			})
		end
		render json: user_list
	end

	def recommend
		if params[:type] == "content"
			resource = Content.find(params[:resource][:id])
		elsif params[:type] == "question"
			resource = Question.find(params[:resource][:id])
		end
		course = Course.find(params[:course_id])
		if course != nil && course.verify_resource(resource)
			target_users = []
			params[:targets].each do |target|
				target_user = User.find(target[:id])
				if target_user != nil
					target_users.push(target_user)
				else
					render json: {error: "User not found"}, status: :unprocessable_entity
					break
				end
			end			
			target_users.each do |target_user|
				recommendation = Recommendation.new
				recommendation.user_source = current_user
				recommendation.user_destination = target_user
				recommendation.resource = resource
				recommendation.course = course
				recommendation.save!
			end
			render json: {success: true}
		else
			render json: {error: "Error! Invalid course or resource."}, status: :unprocessable_entity
		end
	end

	def verify_permissions
    	@permissions = current_user.verify_permissions(['permission.courses.teach', 'permission.courses.take_part'])
    	if @permissions['permission.courses.teach'] || @permissions['permission.courses.take_part']
    		render json: {error: "Unauthorized access"}, status: 401
    	end
    end
	
end