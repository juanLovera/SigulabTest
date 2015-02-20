class RequestsController < ApplicationController
  layout "application_compras"
  respond_to :html, :xml, :json
  before_action :set_request, only: [:show, :edit, :update, :destroy]

  # GET /invitations
  # GET /invitations.json
  def index
    if current_user
    	@requests = Request.where(:specification_id => session[:specification_sel_id]).first
      @sumRequest = Request.where(:specification_id => session[:specification_sel_id]).count
      if @sumRequest != 0
        respond_to do |format|
        format.html { redirect_to @requests, notice: '' }
      end
    end
    end
  end

  # GET /invitations/1
  # GET /invitations/1.json
  def show
    @relation = Request.where(:specification_id => session[:specification_sel_id]).first
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ReporteRelation.new(@relation)
        nombre = "Relacion_Descriptiva_Especificacion_#{session[:specification_sel_id]}_Empresa_#{@invitation.nombre}.pdf"
        send_data pdf.render, filename: nombre, type: 'application/pdf'
      end
    end
  end


  # GET /invitations/new
  def new
    @request = Request.new
  
  end

  # GET /invitations/1/edit
  def edit
    @requests = Request.where(:specification_id => session[:specification_sel_id]).all
  end

  # POST /invitations
  # POST /invitations.json
  def create
    @request = Request.new(request_params)
    @request.specification_id = session[:specification_sel_id]
    respond_to do |format|
      if @request.save
        format.html { redirect_to requests_url, notice: 'Invitation was successfully created.' }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invitations/1
  # PATCH/PUT /invitations/1.json
  def update
    
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to @request, notice: 'Invitation was successfully updated.' }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invitations/1
  # DELETE /invitations/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Invitation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      params.require(:request).permit(:unidad_solicitante, :persona_contacto,:telefono, :email, :fondos, :numero_proyecto, :funcion, :tipo_cuenta, :numero_cuenta, :nombre_banco, :otro, :proforma, :folleto, :fonacit, :acta_consejo_directo)
    end
end