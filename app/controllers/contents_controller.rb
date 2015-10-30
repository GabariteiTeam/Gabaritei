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

	private

		def content_params
			params.require(:content).permit(:id, :name, :description)
		end

		def medium_params
			params.require(:medium).permit(:id, :reference, :data, :is_attachment)
		end

end