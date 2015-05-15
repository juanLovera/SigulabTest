class InvitationsController < ApplicationController
  layout "application_compras"
  respond_to :html, :xml, :json
  before_action :set_invitation, only: [:show, :edit, :update, :destroy]

  # GET /invitations
  # GET /invitations.json
  def index
    if current_user
    	@invitations = Invitation.where(:specification_id => session[:specification_sel_id]).all
      @sumInvitation = Invitation.where(:specification_id => session[:specification_sel_id]).count
	@invitationsAll= Invitation.where(:specification_id => session[:specification_sel_id]).all
	@invitationsItemsAll= Invitation.all().count
	

    end
    
  end

  # GET /invitations/1
  # GET /invitations/1.json
  def show
  specification = Specification.find(session[:specification_sel_id])
    @invitation = Invitation.find(params[:id])
    if specification.user_id == current_user.username
		@propio = true
	else
		@propio = false
	end
	if current_user.acquisition?  || current_user.acquisition_analist?  || current_user.import?  || current_user.import_analist?
		if @propio
			@puedeEliminar = true
		else
			@puedeEliminar = false
		end
	else
		@puedeEliminar = true
	end
	
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ReporteInvitations.new(@invitation)
        nombre = "Especificacion_#{session[:specification_sel_id]}_Carta_Invitacion_Empresa_#{@invitation.nombre}.pdf"
        send_data pdf.render, filename: nombre, type: 'application/pdf'
      end
    end
  end


  # GET /invitations/new
  def new
    @invitation = Invitation.new
  end

  # GET /invitations/1/edit
  def edit
  end

  # POST /invitations
  # POST /invitations.json
  def create
    @invitation = Invitation.new(invitation_params)
    @invitation.user_id = current_user.username
    @invitation.quote_id = -1;
    specification = Specification.find(session[:specification_sel_id])
    specification.p3 = 1
    session[:specification_p3] = specification.p3
    specification.save
    respond_to do |format|
      if @invitation.save
        format.html { redirect_to invitations_url, notice: 'Invitation was successfully created.' }
        format.json { render :show, status: :created, location: @invitation }
      else
        format.html { render :new }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invitations/1
  # PATCH/PUT /invitations/1.json
  def update
    respond_to do |format|
      if @invitation.update(invitation_params)
        format.html { redirect_to @invitation, notice: 'Invitation was successfully updated.' }
        format.json { render :show, status: :ok, location: @invitation }
      else
        format.html { render :edit }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invitations/1
  # DELETE /invitations/1.json
  def destroy
    @invitation.destroy
    @sumInvitation = Invitation.where(:user_id => current_user.username, :specification_id => session[:specification_sel_id]).count
    if @sumInvitation == 0
	specification = Specification.find(session[:specification_sel_id])
    specification.p3 = 0
    session[:specification_p3] = specification.p3
    specification.save
    end
    respond_to do |format|
      format.html { redirect_to invitations_url, notice: 'Invitation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invitation
      @invitation = Invitation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invitation_params
      params.require(:invitation).permit(:nombre, :direccion, :correo, :telefono, :telefono_Adicional, :responsable, :rif, :specification_id, :tipo, :contacto, :correo_contacto, :fecha_tope)
    end
end
