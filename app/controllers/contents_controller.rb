class ContentsController < ApplicationController

	before_action :verify_permissions

    def index
    	if @permissions['permission.contents.globally_manipulate']
			contents = Content.all
			render json: contents, methods: [:subject, :field]
		elsif @permissions['permission.contents.manipulate']
			contents = current_user.contents
			render json: contents, methods: [:subject, :field]
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	def create
		if @permissions['permission.contents.globally_manipulate'] || @permissions['permission.contents.manipulate']
			@content = Content.new(content_params)
			if (medium_params[:data] == "null") 
				params[:medium].delete :data
			end
			@medium = Medium.new(medium_params)
			@content.medium = @medium
			if @content.save
		      	render json: {success: true}
		    else
		      	render json: @course.errors, status: :unprocessable_entity
			end
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	def update
		content = Content.find(params[:id])
		if @permissions['permission.contents.globally_manipulate'] || @permissions['permission.contents.manipulate'] && content.owner == current_user
			medium = content.medium
			if (medium_params[:data] == "null" || !medium_params[:reference].empty?) 
				params[:medium].delete :data
				medium.data = nil
			end
			if content.update(content_params) && medium.update(medium_params)
		      	render json: {success: true}
		    else
		      	render json: content.errors, status: :unprocessable_entity
			end
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	def show
		content = Content.find(params[:id])
		if @permissions['permission.contents.globally_manipulate'] || @permissions['permission.contents.manipulate'] && content.owner == current_user || content.can_be_accessed?(current_user.id) 
			render json: content, methods: [:medium, :attachment_url, :category, :embeddable]
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	def destroy
		content = Content.find(params[:id])
		if @permissions['permission.contents.globally_manipulate'] || @permissions['permission.contents.manipulate'] && content.owner == current_user
			if content.destroy
				render json: {success: true}
			else
				render json: content.errors, status: :unprocessable_entity
			end
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	def contents_for_lesson
		if @permissions['permission.contents.globally_manipulate'] || @permissions['permission.contents.manipulate']
			contents = @permissions['permission.contents.globally_manipulate'] ? Content.all.as_json : current_user.contents.as_json
			if params.has_key?(:lesson_id)
				contents.each do |content|
					content.merge!({in_lesson: LessonContent.exists?(lesson_id: params[:lesson_id], content_id: content[:id])})
				end
			end
			render json: contents
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	private

		def content_params
			params.permit(:id, :name, :description, :shareable, :category_id, :category_type)
		end

		def medium_params
			params.require(:medium).permit(:id, :reference, :data, :is_attachment)
		end

		def verify_permissions
			@permissions = current_user.verify_permissions(['permission.contents.globally_manipulate', 'permission.contents.manipulate'])
		end

end