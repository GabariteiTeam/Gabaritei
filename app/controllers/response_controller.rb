class ResponseController < ApplicationController

	before_action :verify_permissions
	before_action :set_responses, only: [:index]
	
	def index
		if @responses == nil
			render :json =>  @responses, status: :unprocessable_entity
		else
			render json: @responses, methods: [:owner_name, :rating]
		end
	end

	def show
		@response = Response.find(params[:id])
		if @permissions['permission.questions.globally_manipulate'] || @permissions['permission.questions.manipulate'] && @response.question.owner == current_user || @response.owner == current_user
			question = @response.question
			splitted = @response.text.split(', ')
			keys = Array.new
			for i in 1..(splitted.length + 1)
				if splitted.include? "#{i}"
					keys.push true
				else
					keys.push false
				end
			end
			render :json => {response: @response, question: question, keys: keys, choices: question.question_choices}
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end


	def create
		if @permissions['permission.courses.take_part']
			@response = Response.new response_params
			@question = Question.find(params[:question_id])
			@response.question = @question
			
			set_choices
			@response.owner = current_user
			if @response.save
				begin
					if (params[:rating].to_i > 0)
						rating = Rating.where(owner_id: current_user.id, question_id: params[:question_id])
						if rating.length == 0
							rating = Rating.new
							rating.owner = current_user
							rating.question = @question
						else
							rating = rating[0]
						end
						rating.value = params[:rating].to_i
						rating.save!
					end
				rescue
				end
				render :json => {}
			else
				render :json =>  @response.errors, status: :unprocessable_entity
			end
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	def destroy
		@response = Response.find(params[:id])
		if @permissions['permission.questions.globally_manipulate'] || @permissions['permission.questions.manipulate'] && @response.question.owner == current_user || @response.owner == current_user
			if @response.destroy
				render :json => {}
			else
				render :json =>  @response.errors, status: :unprocessable_entity
			end
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	def update
		@response = Response.find(params[:response][:id])
		if @permissions['permission.questions.globally_manipulate'] || @permissions['permission.questions.manipulate'] && @response.question.owner == current_user || @response.owner == current_user
			@question = @response.question
			@response.text = params[:response][:text]
			set_choices
			if @response.save 
				render :json => {}
			else
				render :json => {}
			end
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	private

		def set_responses
			question = Question.find(params[:id])
			if @permissions['permission.questions.globally_manipulate'] || @permissions['permission.questions.manipulate'] && question.owner == current_user
				@responses = Response.where(question_id: params[:id]) rescue nil
			else
				render json: {error: "Unauthorized access"}, status: 401
			end
		end

		def response_params
			params.require(:response).permit(:id, :text, :question_id, :choices)
		end

		def set_choices
			@alternatives = ""
			if not params[:choices].nil?
				i = 0
				@question.question_choices.each do |choice|
					if params[:choices][i] == "true" || params[:choices][i]
						@response.question_choices.push choice
						@alternatives = @alternatives + "#{i + 1}, "
					end
					i = i + 1
				end
				
				@response.text = @alternatives.sub(/, $/, '')
			end
		end

		def verify_permissions
			@permissions = current_user.verify_permissions(['permission.questions.globally_manipulate', 'permission.questions.manipulate', 'permission.courses.take_part'])
		end

end
