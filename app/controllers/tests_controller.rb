class TestsController < ApplicationController

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
        #TODO: redo query
        @questions = Question.where("text LIKE :search_string OR answer LIKE :search_string OR source LIKE :search_string", search_string: params[:search_string])
        render json: @questions
      end

      def add_questions
        set_test
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

      def remove_question
        set_test
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
end
