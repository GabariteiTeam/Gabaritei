class SubjectsController < ApplicationController

	before_action :verify_permissions, except: [:index, :show]

	def index
		@subjects = Subject.all
		render json: @subjects
	end

	def show
		set_subject
		render :json => { name: @subject.name, description: @subject.description, id: @subject.id, fields: @subject.fields}
	end

	def validate_destroy
		set_subject
		if @subject.questions.count > 0
			render :json => { single: false, model_bind: "questions", count: @subject.questions.count}
		else
			render :json => { single: true }
		end
	end

	def edit
		set_subject
		render :json => { name: @subject.name, description: @subject.description, id: @subject.id}
	end

	def create
		@subject = Subject.new(subject_params)
		if @subject.save
			render :json => {}
		else
			render :json =>  @subject.errors, status: :unprocessable_entity
		end
	end

	def update
		set_subject
		if @subject.update(subject_params)
			render :json => {}
		else
			render :json =>  @subject.errors, status: :unprocessable_entity
		end
	end

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

		def set_subject
			@subject = Subject.find(params[:id])
		end

		def subject_params
			params.require(:subject).permit(:id, :name, :description, :subject)
		end

		def verify_permissions
			@permissions = current_user.verify_permissions(['permission.subjects_fields.manipulate'])
			if !@permissions['permission.subjects_fields.manipulate']
				render json: {error: "Unauthorized access"}, status: 401
			end
		end

end
