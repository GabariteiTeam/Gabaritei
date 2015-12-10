class RatingsController < ApplicationController

	def index
		if params.has_key?(:question_id)
			rating = Rating.where(owner_id: current_user.id, question_id: params[:question_id])
			render json: rating
		else
			render json: {error: "No question"}, status: 422
		end
	end

end