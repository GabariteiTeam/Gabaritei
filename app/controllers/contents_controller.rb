class ContentsController < ApplicationController

    def index
		@contents = Content.all
		render json: @contents
	end

	def create
		@content = Content.new(content_params)
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
		if (params["medium"]["data"] == "null") 
			params["medium"]["data"] = nil
		end
		if @content.update(content_params) && @medium.update(medium_params)
	      	render json: {success: true}
	    else
	      	render json: @course.errors, status: :unprocessable_entity
		end
	end

	def show
		@content = Content.find(params[:id])
		render json: @content, methods: [:medium, :attachment_url]
	end

	def destroy
		Content.find(params[:id]).destroy
		render json: {success: true}
	end

	private

		def content_params
			params.permit(:id, :name, :description)
		end

		def medium_params
			params.require(:medium).permit(:id, :reference, :data, :is_attachment)
		end

end