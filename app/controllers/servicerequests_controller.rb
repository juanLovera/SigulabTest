class ServicerequestsController < ApplicationController
  layout "application_compras"
  before_action :set_servicerequest, only: [:show, :edit, :update, :destroy]

  # GET /servicerequests
  # GET /servicerequests.json
   def index

     if current_user
         @servicerequests = Servicerequest.where(:user_id => current_user.username).all
         @sumServReq = Servicerequest.where(:user_id => current_user.username).count
         @servreq = Servicerequest.where(:user_id => current_user.username, :specification_id => session[:specification_sel_id]).first
     end
     respond_to do |format|
       format.html do
         if @sumServReq != 0
           redirect_to @servreq
         end
       end
       format.pdf do

         #Revisamos si es un Acto Motivado
         if Recommendation.where(:specification_id => session[:specification_sel_id]).count == 0
            @act = Act.where(:specification_id => session[:specification_sel_id]).first
            @empresa = Invitation.where(:nombre => @act.proveedor,:specification_id => session[:specification_sel_id])
            @quote = Quote.where(:specification_id => session[:specification_sel_id]).first
            @itemsQts = Itemsquote.where(:specification_id => session[:specification_sel_id],:id_oferta => @recoEmp.quote_id,:compra => 1).all
            @items = []

            pdf = SolicitudServices.new(@servreq, @empresa, @items, @quote)
         end

         #Revisamos si es una Recomendacion
         if Recommendation.where(:specification_id => session[:specification_sel_id]).count != 0
           @reco = Recommendation.where(:specification_id => session[:specification_sel_id]).first
           @recoEmp = RecommendationsEmpresa.where(:id_informe => @reco.id, :opcion_numero => 1).first
           @empresa = Invitation.where(:quote_id => @recoEmp.quote_id).first
           #ERROR VACIO
           @quote = Quote.where(:id => @empresa.quote_id, :specification_id => session[:specification_sel_id]).first
           #ERROR VACIO
           @itemsQts = Itemsquote.where(:specification_id => session[:specification_sel_id],:id_oferta => @recoEmp.quote_id,:compra => 1).all
           @items = []
           @itemsQts.each do |itemsqts|
             @items.push(Service.where(:specification_id => session[:specification_sel_id],:id => itemsqts.id_item).first)
           end

           pdf = SolicitudServices.new(@servreq, @empresa, @items, @quote)
         end

         nombre = "Solicitud_#{session[:specification_sel_id]}_de_Servicios.pdf"
         send_data pdf.render, filename: nombre, type: 'application/pdf'
       end
       format.xml do
         specification = Specification.find(session[:specification_sel_id])
         specification.p2 = 2
         specification.p3 = 2
         specification.p4 = 2
         specification.p5 = 0
         specification.p6 = 1
         specification.p8 = 1
         session[:specification_p3] = specification.p3
         session[:specification_p2] = specification.p2
         session[:specification_p4] = specification.p4
         session[:specification_p5] = specification.p5
         session[:specification_p6] = specification.p6
         session[:specification_p8] = specification.p8
         specification.save
         redirect_to "/servicerequests/#{@servreq.id}?pdf=1"
       end
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
