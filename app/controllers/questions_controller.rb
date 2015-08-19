class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  helper QuestionsHelper
  # GET /questions
  # GET /questions.json
  def index
    render json: Question.all
  end


  # GET /questions/1
  # GET /questions/1.json
  def show
    render :json => @question
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
    
    params["subjects"].each do |id|
      subject = Subject.find(id)
      @question.subjects.push(subject)
    end

    if @question.save
      render :json => {}
    else
      render :json =>  @subject.errors, status: :unprocessable_entity
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
    if @question.destroy
      render :json => {}
    else
      render :json =>  @subject.errors, status: :unprocessable_entity
    end
  end

  def getQuestionsSubject
    response = Array.new
    if not params.has_key?("id")
      logger.info("Parameters: #{params}")
      @questions = Question.all
      response.push @questions
    else
      logger.info "[DEBUG] #{params[:id]}"
      logger.info "[DEBUG] #{params[:id] == 0}"
      if params[:id] == "0"
        @questions = Question.all
        response.push @questions
      else
        @questions = Question.where(subject_id: params[:id])
        response.push @questions
      end
    end

    subjects = Subject.all 

    response.push subjects

    render json: response
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:text, :style, :answer, :source, :hot, :subjects)
    end
end
