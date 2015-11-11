class ResponseController < ApplicationController
	before_action :set_responses, only: [:index]
	def index
		if @responses == nil
			render :json =>  @responses, status: :unprocessable_entity
		else
			render json: @responses
		end
	end

	def show
		@response = Response.find(params[:id])
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
	end


	def create
		@response = Response.new response_params
		@question = Question.find(params[:question_id])
		@response.question = @question
		
		set_choices

		if @response.save
			render :json => {}
		else
			render :json =>  @response.errors, status: :unprocessable_entity
		end
	end

	def destroy
		@response = Response.find(params[:id])
		if @response.destroy
			render :json => {}
		else
			render :json =>  @response.errors, status: :unprocessable_entity
		end
	end

	def update
		@response = Response.find(params[:response][:id])
		@question = @response.question
		@response.text = params[:response][:text]
		set_choices
		if @response.save 
			render :json => {}
		else
			render :json => {}
		end
	end



	private
	# Use callbacks to share common setup or constraints between actions.
	def set_responses
		@responses = Response.where(question_id: params[:id] ) rescue nil
	end
	# Never trust parameters from the scary internet, only allow the white list through.
	def response_params
	#params.require(:subject).permit(:name, :professor_id, :department_id, :descricao)
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

  end
