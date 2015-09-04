class FieldsController < ApplicationController

      # GET /fields
      def index
        @fields = Subject.find(params[:id]).fields
        render json: @fields
      end

      # GET /subjects/1
      # GET /subjects/1.json
      def show
        set_subject
        render :json => { name: @subject.name, description: @subject.description, id: @subject.id, fields: @subject.fields}
      end

      # GET /fields/new
      def new
      end

      # GET /subjects/1/edit
      def edit
        set_subject
        render :json => { name: @subject.name, description: @subject.description, id: @subject.id}
      end

      # POST /fields
      def create
        @field = Field.new(fields_params)
        @subject = Subject.find(params[:subject_id]);
        @subject.fields.push(@field)
        if @field.save && @subject.save
          render :json => {}
        else
          render :json =>  @fields.errors, status: :unprocessable_entity
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
        set_field
        if @field.destroy
          render :json => {}
        else
          render :json =>  @subject.errors, status: :unprocessable_entity
        end
      end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_fields
          @fields = Subject.find(params[:id]).fields
        end
        
        def set_field
            @field = Field.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def fields_params
          #params.require(:subject).permit(:name, :professor_id, :department_id, :descricao)
          params.require(:field).permit(:id, :name, :description)
        end
end
