class TestsController < ApplicationController
      before_action :set_test, only: [:search_questions, :add_questions, :has_question, :remove_question, :submit_responses, :get_summary]
      # GET /tests
      # GET /tests.json
      def index
        @tests = Test.all
        render json: @tests, methods: [:course, :questions]
      end

      # POST /tests
      # POST /tests.json
      def create
        @test = Test.new(test_params)
        if @test.save
          render :json => {success: true}
        else
          render :json =>  @test.errors, status: :unprocessable_entity
        end
      end

      # GET /tests/1
      # GET /tests/1.json
      def show
        set_test
        @available_questions = @test.available_questions
        render json: @test, methods: [:course, :questions, :available_questions]
      end

      # PATCH/PUT /tests/1
      # PATCH/PUT /tests/1.json
      def update
        set_test
        if @test.update(test_params)
          render :json => {success: true}
        else
          render :json =>  @test.errors, status: :unprocessable_entity
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
                  if question.text.include?(search_string)
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
        questions = @test.questions.to_a
        questions.delete_if {|question| question.id == params[:question_id].to_i}
        p questions
        @test.questions = questions
        if @test.save
              render json: {success: true}
        else
              render json: @test.errors, status: :unprocessable_entity
        end 
      end

      # DELETE /tests/1
      # DELETE /tests/1.json
    def destroy
        set_test
        if @test.destroy
          render :json => {success: true}
        else
          render :json =>  @test.errors, status: :unprocessable_entity
        end
      end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_test
          @test = Test.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
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
