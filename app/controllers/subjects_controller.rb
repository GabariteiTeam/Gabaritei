class SubjectsController < ApplicationController

    before_action :set_subject, only: [:show, :edit, :update, :destroy]

      # GET /subjects
      # GET /subjects.json
      def index
        @subjects = Subject.all
        render json: @subjects
      end

      # GET /subjects/1
      # GET /subjects/1.json
      def show
        render :json => { name: @subject.name, description: @subject.description, id: @subject.id}
      end

      # GET /subjects/new
      def new
        @subject = Subject.new
      end

      # GET /subjects/1/edit
      def edit
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

        # respond_to do |format|
        #   if @subject.save
        #     #format.html { redirect_to @subject, notice: 'Subject was successfully created.' }
        #     format.json { render :show, status: :created, location: @subject }
        #   else
        #     format.html { render :new }
        #     format.json { render json: @subject.errors, status: :unprocessable_entity }
        #   end
        # end
      end

      # PATCH/PUT /subjects/1
      # PATCH/PUT /subjects/1.json
      def update
        if @subject.update(subject_params)
          render :json => {}
        else
          render :json =>  @subject.errors, status: :unprocessable_entity
        end
        # respond_to do |format|
        #   if @subject.update(subject_params)
        #     format.json {}
        #   else
        #     format.json { render json: @subject.errors, status: :unprocessable_entity }
        #   end
        # end
      end

      # DELETE /subjects/1
      # DELETE /subjects/1.json
    def destroy
        if @subject.destroy
          render :json => {}
        else
          render :json =>  @subject.errors, status: :unprocessable_entity
        end
        # respond_to do |format|
        #   format.html { redirect_to subjects_url, notice: 'Subject was successfully destroyed.' }
        #   format.json { head :no_content }
        # end
      end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_subject
          @subject = Subject.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def subject_params
          #params.require(:subject).permit(:name, :professor_id, :department_id, :descricao)
          params.require(:subject).permit(:id, :name, :description)
        end
end
