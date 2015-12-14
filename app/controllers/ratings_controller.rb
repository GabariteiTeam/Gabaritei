class RatingsController < ApplicationController

	def rating_of_current_user
		if params.has_key?(:question_id)
			rating = Rating.where(owner_id: current_user.id, question_id: params[:question_id])
			if rating.length > 0
				render json: rating
			else
				render json: {}
			end
		else
			render json: {error: "No question"}, status: 422
		end
	end

end