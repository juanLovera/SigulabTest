class RecommendationsController < ApplicationController
  layout "application_compras"
  before_action :set_recommendation, only: [:show, :edit, :update, :destroy]

  def index
    if current_user
    @recommendations = Recommendation.where(:user_id => current_user.username, :specification_id => session[:specification_sel_id]).all
    @sumRec = Recommendation.where(:user_id => current_user.username, :specification_id => session[:specification_sel_id]).count
    end
    respond_to do |format|
	      format.html
	      format.pdf do
		@reco = Recommendation.where(:user_id => current_user.username, :specification_id => session[:specification_sel_id]).first
		@invt = Invitation.where(:specification_id => session[:specification_sel_id]).all
		@recoEmp = RecommendationsEmpresa.where(:id_informe => @reco.id).all
		@itemsq = Itemsquote.where(:specification_id => session[:specification_sel_id]).all
		pdf = ReporteRecommendations.new(@reco, @recoEmp, @invt, @itemsq)
		nombre = "Informe_Recomendacion_Especificacion_#{session[:specification_sel_id]}.pdf"
		send_data pdf.render, filename: nombre, type: 'application/pdf'
	      end
	      format.xml do
              specification = Specification.find(session[:specification_sel_id])
	       specification.p2 = 2
	       specification.p3 = 2
	       specification.p4 = 2
	       specification.p5 = 0
	       specification.p6 = 1
	       session[:specification_p3] = specification.p3
	    session[:specification_p2] = specification.p2
	    session[:specification_p4] = specification.p4
	    session[:specification_p5] = specification.p5
	    session[:specification_p6] = specification.p6
	    specification.save
              redirect_to "/recommendations?pdf=1"
      end
      end
   	
  end

  # GET /quotes/1
  # GET /quotes/1.json
  def show
     @recommendation = Recommendation.where(:user_id => current_user.username, :specification_id => session[:specification_sel_id]).first
     @empresas_todas = Invitation.where(:specification_id => session[:specification_sel_id]).all
     @empresas = RecommendationsEmpresa.where(:id_informe => @recommendation.id).all
     @itemsquote = Itemsquote.where(:specification_id => session[:specification_sel_id]).all
  end

  # GET /quotes/new
  def new
        num = Recommendation.where(:user_id => current_user.username, :specification_id => session[:specification_sel_id]).count
	if num != 0
	@recommendation = Recommendation.where(:user_id => current_user.username, :specification_id => session[:specification_sel_id]).first
        else
    	@recommendation = Recommendation.new
        end
    @quotes = Quote.where(:user_id => current_user.username, :specification_id => session[:specification_sel_id]).all
    @itemsquotes = Itemsquote.where(:specification_id => session[:specification_sel_id]).all
  end

  # GET /quotes/1/edit
  def edit
  end

  # POST /quotes
  # POST /quotes.json
  def create
        num = Recommendation.where(:user_id => current_user.username, :specification_id => session[:specification_sel_id]).count
	if num != 0
		@recommendation = Recommendation.where(:user_id => current_user.username, :specification_id => session[:specification_sel_id]).first
		@recommendation.destroy
        end
    @recommendation = Recommendation.new(recommendation_params)
    @recommendation.user_id = current_user.username
    @recommendation.specification_id = session[:specification_sel_id]
    @recommendation.save
    params.each do |k,x|
    if k.include?("recommendation_empresas")
      ind = k.gsub("recommendation_empresas", "")
      @nuevoElemento = RecommendationsEmpresa.new
      @nuevoElemento.quote_id = params["quoteid#{ind}"]
      @nuevoElemento.id_informe = @recommendation.id
      @nuevoElemento.opcion_numero = params["prioridad#{ind}"]
      @nuevoElemento.empresa = params["empresa#{ind}"]
      @nuevoElemento.calidad_pro = params["calidadProd#{ind}"]
      @nuevoElemento.disponibilidad_pro = params["disponibilidad#{ind}"]
      @nuevoElemento.proveedor_unico = params["proveedorU#{ind}"]
      @nuevoElemento.calidad_ser = params["calidadServ#{ind}"]
      @nuevoElemento.garantia = params["garantia#{ind}"]
      @nuevoElemento.servicio_post = params["servicioPV#{ind}"]
      @nuevoElemento.cumplimiento_esp = params["cumplimientoEsp#{ind}"]
      @nuevoElemento.precio = params["precio#{ind}"]
      @nuevoElemento.tiempo = params["tiempoE#{ind}"]
      @nuevoElemento.cumplio_req = 1
      @nuevoElemento.save
      @quotes = Itemsquote.where(:id_oferta => params["quoteid#{ind}"]).all
      @quotes.each do |quot|
	quot.compra = 1
	quot.save
      end
    end
    end

    respond_to do |format|
     
        format.html { redirect_to recommendations_url, notice: 'Recommendation was successfully created.' }
        format.json { render :show, status: :created, location: @Recommendation }
   
    end
  end

  # PATCH/PUT /quotes/1
  # PATCH/PUT /quotes/1.json
  def update
    create
  end

  # DELETE /quotes/1
  # DELETE /quotes/1.json
  def destroy
    @recommendation = Recommendation.where(:user_id => current_user.username, :specification_id => session[:specification_sel_id]).first
    @recommendation.destroy
    respond_to do |format|
      format.html { redirect_to recommendations_url, notice: 'Recommendation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recommendation
      @recommendation = Recommendation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recommendation_params
      params.require(:recommendation).permit(:codigo,:via)
    end
end