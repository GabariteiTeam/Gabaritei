class ContentsController < ApplicationController

    def index
    	
		@contents = Content.all
		render json: @contents, methods: [:subject, :field]
	end

	def create
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
	end

	def update
		@content = Content.find(params[:id])
		@medium = @content.medium
		if (medium_params[:data] == "null" || !medium_params[:reference].empty?) 
			params[:medium].delete :data
			@medium.data = nil
		end
		if @content.update(content_params) && @medium.update(medium_params)
	      	render json: {success: true}
	    else
	      	render json: @course.errors, status: :unprocessable_entity
		end
	end

	def show
		@content = Content.find(params[:id])
		render json: @content, methods: [:medium, :attachment_url, :category, :embeddable]
	end

	def destroy
		Content.find(params[:id]).destroy
		render json: {success: true}
	end

	def contents_for_lesson
		contents = Content.all.as_json
		if params.has_key?(:lesson_id)
			contents.each do |content|
				content.merge!({in_lesson: LessonContent.exists?(lesson_id: params[:lesson_id], content_id: content[:id])})
			end
		end
		render json: contents
	end

	private

		def content_params
			params.permit(:id, :name, :description, :shareable, :category_id, :category_type)
		end

		def medium_params
			params.require(:medium).permit(:id, :reference, :data, :is_attachment)
		end

end