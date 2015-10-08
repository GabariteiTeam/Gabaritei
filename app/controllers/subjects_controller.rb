class SubjectsController < ApplicationController

      # GET /subjects
      # GET /subjects.json
      def index
        @subjects = Subject.all
        render json: @subjects
      end

      # GET /subjects/1
      # GET /subjects/1.json
      def show
        set_subject
        render :json => { name: @subject.name, description: @subject.description, id: @subject.id, fields: @subject.fields}
      end

      # GET /subjects/new
      def new
        @subject = Subject.new
      end

      # checks to see related models
      def validate_destroy
        set_subject
        if @subject.questions.count > 0
          render :json => { single: false, model_bind: "questions", count: @subject.questions.count}
        else
          render :json => { single: true }
        end
      end

      # GET /subjects/1/edit
      def edit
        set_subject
        render :json => { name: @subject.name, description: @subject.description, id: @subject.id}
      end

      # POST /subjects
      # POST /subjects.json
      def create
        @subject = Subject.new(subject_params)
        if @subject.save
          render :json => {}
        else
          render :json =>  @subject.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /subjects/1
      # PATCH/PUT /subjects/1.json
      def update
        set_subject
        if @subject.update(subject_params)
          render :json => {}
        else
          render :json =>  @subject.errors, status: :unprocessable_entity
        end
      end

      # DELETE /subjects/1
      # DELETE /subjects/1.json
    def destroy
        set_subject
        @subject.questions.each do |question|
          question.destroy
        end
        @subject.fields.each do |field|
          field.destroy
        end
        if @subject.destroy
          render :json => {}
        else
          render :json =>  @subject.errors, status: :unprocessable_entity
        end
      end

    def fields
      set_subject
      @fields = @subject.fields
      render :json => @fields
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_subject
          @subject = Subject.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def subject_params
          #params.require(:subject).permit(:name, :professor_id, :department_id, :descricao)
          params.require(:subject).permit(:id, :name, :description, :subject)
        end
end
