class TestsController < ApplicationController

      # GET /tests
      # GET /tests.json
      def index
        @tests = Test.all
        render json: @tests
      end

      # GET /tests/1
      # GET /tests/1.json
      def show
        set_test
        render :json => { name: @test.name, description: @test.description, id: @test.id}
      end

      # GET /tests/new
      def new
        @test = Test.new
      end

      # # checks to see related models
      # def validate_destroy
      #   set_test
      #   render :json => { single: true }
      # end

      # GET /tests/1/edit
      def edit
        set_test
        render :json => { name: @test.name, description: @test.description, id: @test.id}
      end

      # POST /tests
      # POST /tests.json
      def create
        @test = Test.new(test_params)
        if @test.save
          render :json => {}
        else
          render :json =>  @test.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /tests/1
      # PATCH/PUT /tests/1.json
      def update
        set_test
        if @test.update(test_params)
          render :json => {}
        else
          render :json =>  @test.errors, status: :unprocessable_entity
        end
      end

      # DELETE /tests/1
      # DELETE /tests/1.json
    def destroy
        set_test
        # @test.questions.each do |question|
        #   question.destroy
        # end
        # @test.fields.each do |field|
        #   field.destroy
        # end
        if @test.destroy
          render :json => {}
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
          #params.require(:test).permit(:name, :professor_id, :department_id, :descricao)
          params.require(:test).permit(:id, :name, :description, :test)
        end
end
