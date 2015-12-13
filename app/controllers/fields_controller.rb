class FieldsController < ApplicationController

	before_action :verify_permissions, except: [:index]

	def index	
		@fields = Subject.find(params[:id]).fields
		render json: @fields
	end
			
	def edit
		set_field
		render json: @field
	end

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

	def update
		set_field
		if @field.update(fields_params)
			render :json => {}
		else
			render :json =>  @subject.errors, status: :unprocessable_entity
		end
	end

	def destroy
		set_field
		if @field.destroy
			render :json => {}
		else
			render :json =>  @subject.errors, status: :unprocessable_entity
		end
	end

	private
       
		def set_field
			@field = Field.find(params[:id])
		end

		def fields_params
			params.require(:field).permit(:id, :name, :description)
		end

		def verify_permissions
			@permissions = current_user.verify_permissions(['permission.subjects_fields.manipulate'])
			if !@permissions['permission.subjects_fields.manipulate']
				render json: {error: "Unauthorized access"}, status: 401
			end
		end

end
