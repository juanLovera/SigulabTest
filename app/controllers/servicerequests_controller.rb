class ServicerequestsController < ApplicationController
  layout "application_compras"
  respond_to :html, :xml, :json
  before_action :set_servicerequest, only: [:show, :edit, :update, :destroy]

  # GET /servicerequests
  # GET /servicerequests.json
   def index
    if current_user
        @servicerequests = Servicerequest.where(:user_id => current_user.username).all
        @sumServicerequest = Servicerequest.where(:user_id => current_user.username).count
    end
  end
  # GET /servicerequests/1
  # GET /servicerequests/1.json
  def show
    @servicerequest = Servicerequest.find(params[:id])

  end

  # GET /servicerequests/new
  def new
    @servicerequest= Servicerequest.new
  end

  # GET /servicerequests/1/edit
  def edit
  end

  # POST /servicerequests
  # POST /servicerequests.json
  def create
    @servicerequest = Servicerequest.new(servicerequest_params)
    @servicerequest.user_id = current_user.username
    @servicerequest.specification_id = session[:specification_sel_id]
    respond_to do |format|
      if @servicerequest.save
        format.html { redirect_to @servicerequest, notice: 'Service request was successfully created.' }
        format.json { render :show, status: :created, location: @servicerequest}
      else
        format.html { render :new }
        format.json { render json: @servicerequest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /servicerequests/1
  # PATCH/PUT /servicerequests/1.json
  def update
    respond_to do |format|
      if @servicerequest.update(servicerequest_params)
        format.html { redirect_to @servicerequest, notice: 'Service request was successfully updated.' }
        format.json { render :show, status: :ok, location: @servicerequest }
      else
        format.html { render :edit }
        format.json { render json: @servicerequest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /servicerequests/1
  # DELETE /servicerequests/1.json
  def destroy
    @servicerequest.destroy
    respond_to do |format|
      format.html { redirect_to servicerequests_url, notice: 'Service request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_servicerequest
      @servicerequest = Servicerequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def servicerequest_params
      params.require(:servicerequest).permit(:seccion, :contacto_int, :nombre, :ubicacion, :monto)
    end
end
