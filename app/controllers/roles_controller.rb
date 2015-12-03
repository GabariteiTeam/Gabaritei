class RolesController < ApplicationController

  # GET /roles
  # GET /roles.json
  def index
    if params.has_key?(:take_part_in_courses)
      @roles = Role.joins(:permissions).where(permissions: { name: 'permission.courses.take_part' })
    else
      @roles = Role.all
    end
    render json: @roles
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
    role = Role.includes(:permissions).find(params[:id])
    render json: role, methods: [:permissions]
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
    if params["permissions"]
      @role.permissions = Permission.find(params["permissions"])
    end
    if @role.save
      render :json => {}
    else
      render :json =>  @role.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /Roles/1
  # PATCH/PUT /Roles/1.json
  def update
    set_role
    @role.permissions = []
    if params["permissions"]
      @role.permissions = Permission.find(params["permissions"])
    end
    if @role.update(role_params)
      render :json => {}
    else
      render :json =>  @role.errors, status: :unprocessable_entity
    end
  end

  # DELETE /Roles/1
  # DELETE /Roles/1.json
  def destroy
    set_role
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

  def validate_destroy
    set_role
    user_count = @role.users.count
    if user_count > 0
      render :json => { single: false, count: user_count}
    else
      render :json => { single: true }
    end
  end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      #params.require(:Role).permit(:name, :professor_id, :department_id, :descricao)
      params.require(:role).permit(:id, :name, :description)
    end
end
