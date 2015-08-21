class RolesController < ApplicationController

  # GET /roles
  # GET /roles.json
  def index
    @roles = Role.all
    render json: @roles
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
    render :json => { name: @role.name, description: @role.description, id: @role.id}
  end

  # GET /Roles/new
  def new
    @role = Role.new
  end

  # GET /Roles/1/edit
  def edit
  end

      # POST /Roles
      # POST /Roles.json
      def create
        @role = Role.new(role_params)
        if @role.save
          render :json => {}
        else
          render :json =>  @role.errors, status: :unprocessable_entity
        end

        # respond_to do |format|
        #   if @role.save
        #     #format.html { redirect_to @role, notice: 'Role was successfully created.' }
        #     format.json { render :show, status: :created, location: @role }
        #   else
        #     format.html { render :new }
        #     format.json { render json: @role.errors, status: :unprocessable_entity }
        #   end
        # end
      end

      # PATCH/PUT /Roles/1
      # PATCH/PUT /Roles/1.json
      def update
        if @role.update(role_params)
          render :json => {}
        else
          render :json =>  @role.errors, status: :unprocessable_entity
        end
        # respond_to do |format|
        #   if @role.update(role_params)
        #     format.json {}
        #   else
        #     format.json { render json: @role.errors, status: :unprocessable_entity }
        #   end
        # end
      end

      # DELETE /Roles/1
      # DELETE /Roles/1.json
    def destroy
        if @role.destroy
          render :json => {}
        else
          render :json =>  @role.errors, status: :unprocessable_entity
        end
        # respond_to do |format|
        #   format.html { redirect_to Roles_url, notice: 'Role was successfully destroyed.' }
        #   format.json { head :no_content }
        # end
      end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_Role
          @role = Role.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def role_params
          #params.require(:Role).permit(:name, :professor_id, :department_id, :descricao)
          params.require(:Role).permit(:id, :name, :description)
        end
end
