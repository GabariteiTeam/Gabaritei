class TestsController < ApplicationController

	before_action :verify_permissions
	before_action :set_test, only: [:search_questions, :add_questions, :has_question, :remove_question, :submit_responses, :get_summary]

	def index
		if @permissions['permission.courses.globally_manipulate'] || @permissions['permission.courses.teach'] || @permissions['permission.courses.take_part']
			@tests = @permissions['permission.courses.globally_manipulate'] ? Test.all : Test.user_tests(current_user)
			render json: @tests, methods: [:course, :questions]
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	def create
		if @permissions['permission.courses.globally_manipulate'] || @permissions['permission.courses.teach']
			@test = Test.new(test_params)
			if @test.save
				render :json => {success: true}
			else
				render :json =>  @test.errors, status: :unprocessable_entity
			end
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	def show
		set_test
		@available_questions = @test.available_questions
		render json: @test, methods: [:course, :questions, :available_questions]
	end

	def update
		set_test
		if @permissions['permission.courses.globally_manipulate'] || @permissions['permission.courses.teach'] && current_user.courses.include?(@test.course)
			if @test.update(test_params)
				render :json => {success: true}
			else
				render :json =>  @test.errors, status: :unprocessable_entity
			end
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	def search_questions
		questions = @test.available_questions
		search_string = params[:search_string]
		# using raw filtering
		# could be better, in a next work :)
		if !search_string.nil?
			@filtered_questions = Array.new
			questions.each do |question|
				if !question.nil?
					if question.text.downcase.include?(search_string.downcase)
							@filtered_questions.push question
					end
				end
			end
		else
			@filtered_questions = questions
		end
		render json: @filtered_questions
	end

	def add_questions
		if @permissions['permission.courses.globally_manipulate'] || @permissions['permission.courses.teach'] && current_user.courses.include?(@test.course)
			questions = @test.questions.to_a
			params[:questions].each do |question|
				question = Question.find(question[:id])
				questions.push(question)
			end
			@test.questions = questions.uniq
			if @test.save
				render json: {success: true}
			else
				render json: @test.errors, status: :unprocessable_entity
			end 
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	def submit_responses
		old_responses = @test.responses.where(:owner == current_user)
		if old_responses.size > 0
			old_responses.delete_all
		end

		params[:summary].each do |summary|
			response = Response.new
			question = Question.find(summary[:question_id])
			response.owner = current_user
			response.text = summary[:response]
			response.question = question
			set_choices summary[:keys], response, question
			response.save
			@test.responses.push(response)
			puts "new!"
		end

		if @test.save
			render json: {success: true}
		else
			render json: @test.errors, status: :unprocessable_entity
		end 
	end

	def get_summary
		responses = @test.responses.where(:owner == current_user).all
		summary = []
		responses.each do |response|
			partial_response = {}
			partial_response[:question_id] = response.question.id
			partial_response[:response] = response.text
			if response.question.style == Question::STYLE_CHOICE
				splitted = response.text.split(', ')
				keys = Array.new
				for i in 1..(splitted.length + 1)
					if splitted.include? "#{i}"
						keys.push true
					else
						keys.push false
					end
				end
			end
			partial_response[:keys] = keys
			partial_response[:style] = response.question.style
			summary.push(partial_response)
		end
		render :json => {:summary => summary, :test_name => @test.name}
	end

	def remove_question
		if @permissions['permission.courses.globally_manipulate'] || @permissions['permission.courses.teach'] && current_user.courses.include?(@test.course)
			questions = @test.questions.to_a
			questions.delete_if {|question| question.id == params[:question_id].to_i}
			p questions
			@test.questions = questions
			if @test.save
				render json: {success: true}
			else
				render json: @test.errors, status: :unprocessable_entity
			end 
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	def destroy
		set_test
		if @permissions['permission.courses.globally_manipulate'] || @permissions['permission.courses.teach'] && current_user.courses.include?(@test.course)
			if @test.destroy
				render :json => {success: true}
			else
				render :json =>  @test.errors, status: :unprocessable_entity
			end
		else
			render json: {error: "Unauthorized access"}, status: 401
		end
	end

	private

		def verify_permissions
			@permissions = current_user.verify_permissions(['permission.courses.globally_manipulate', 'permission.courses.teach', 'permission.courses.take_part'])
		end

		def set_test
			@test = Test.find(params[:id])
		end

		def test_params
			params.require(:test).permit(:id, :name, :description, :test, :course_id)
		end

		def set_choices alternative, response, question
			alternatives = ""
			if not alternative.nil?
				i = 0
				question.question_choices.each do |choice|
					if alternative[i] == "true" || alternative[i]
						response.question_choices.push choice
						alternatives = alternatives + "#{i + 1}, "
					end
					i = i + 1
				end
				response.text = alternatives.sub(/, $/, '')
			end
		end

end
