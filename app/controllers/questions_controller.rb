class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  helper QuestionsHelper
  # GET /questions
  # GET /questions.json
  def index
    render json: Question.all, methods: [:owner_name]
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    subjects = []
    @question.subjects.each do |subject|
      j_subject = {:id => subject.id, :name => subject.name}
      subjects.append(j_subject)
    end
    j_question_choices = []
    if @question.style == Question::STYLE_CHOICE
      @question.question_choices.each do |choice|
        j_question_choices.push(choice)
      end
    end
    render :json => {:question => @question, :subjects => subjects, :choices => j_question_choices, :category_list => @question.category_list}
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
    
    # if question is alternativce
    if @question.style == Question::STYLE_CHOICE
      # register each response
      if not params[:choices].nil?
        params[:choices].each do |choice|
          q_choice = QuestionChoice.new
          q_choice.text = choice
          q_choice.save
          @question.question_choices.push q_choice
        end
      end
    end


    # validation of subjects as array (avoid crashes)
    if not params[:subjects].nil?
      if params[:subjects].class == Array
        params[:subjects].each do |id|
          subject = Subject.find(id)
          @question.subjects.push(subject)
        end
      end
    end

    @question.owner = current_user
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

  def customUpdate
    @question = Question.find(question_params["id"])
    set_choices
    if set_subjects
      if @question.update(question_params)
        render :json => {}
      else
        render :json => @subject.errors, status: :unprocessable_entity
      end
    else
      render :json => "Error updating", status: :unprocessable_entity
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

  def questions_for_lesson
    questions = Question.all.as_json(methods: [:description])
    if params.has_key?(:lesson_id)
      questions.each do |question| 
          question.merge!({in_lesson: LessonQuestion.exists?(lesson_id: params[:lesson_id], question_id: question[:id])})
      end
    end
    render json: questions
  end


  private
    # Helper to update subjects
    def set_subjects
      #Start from zero
      @question.subjects.clear
      params["question"]["subjects"].each do |subject|
        if Subject.find(subject)
          @question.subjects.append Subject.find(subject)
        else
          logger.info("[DEBUG] Error finding subject")
          return
        end
      end
    end

    def set_choices
      # erase all responses
      @question.question_choices.each do |choice|
        choice.destroy
      end
      # create each answer
      if not params[:choices].nil?
        params[:choices].each do |choice|
          q_choice = QuestionChoice.new
          q_choice.text = choice
          q_choice.save
          if q_choice == @question.answer
            q_choice.correct = true
          end
          @question.question_choices.push q_choice
        end
      end
    end



    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:id, :text, :style, :answer, :source, :hot, :subjects, :choices)
    end
end
