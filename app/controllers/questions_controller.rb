class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  helper QuestionsHelper
  # GET /questions
  # GET /questions.json
  def index
    if not params.has_key?("subject_id")
      logger.info("Parameters: #{params}")
      @questions = Question.all
    else
      logger.info "[DEBUG] #{params[:subject_id]}"
      logger.info "[DEBUG] #{params[:subject_id] == 0}"
      if params[:subject_id] == "0"
        @questions = Question.all
      else
        @questions = Question.where(subject_id: params[:subject_id])
      end
    end 
    
    
    #Para criar dropdown com filtro
    @subjects = Subject.all
    
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
    @subjects = Subject.all
  end

  # GET /questions/1/edit
  def edit
  end
  

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:question, :style, :year, :area, :subject_id, :hot)
    end
end
