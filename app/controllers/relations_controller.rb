class RelationsController < ApplicationController
  layout "application_compras"
  respond_to :html, :xml, :json
  before_action :set_relation, only: [:show, :edit, :update, :destroy]

  # GET /invitations
  # GET /invitations.json
  def index
    if current_user
    	@relations = Relation.where(:specification_id => session[:specification_sel_id]).all
      @sumRelation = Relation.where(:specification_id => session[:specification_sel_id]).count
      @items = Item.where(:specification_id => session[:specification_sel_id]).all
    end
  end

  # GET /invitations/1
  # GET /invitations/1.json
  def show
    @relation = Relation.find(params[:id])
    @item = Item.where(:id => @relation.item_id).first
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
    @relation = Relation.new
    @items = Item.where(:specification_id => session[:specification_sel_id]).all
  end

  # GET /invitations/1/edit
  def edit
    @items = Item.where(:specification_id => session[:specification_sel_id]).all
  end

  # POST /invitations
  # POST /invitations.json
  def create
    @relation = Relation.new(relation_params)
    @relation.specification_id = session[:specification_sel_id]
    respond_to do |format|
      if @relation.save
        format.html { redirect_to relations_url, notice: 'Invitation was successfully created.' }
        format.json { render :show, status: :created, location: @relation }
      else
        format.html { render :new }
        format.json { render json: @relation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invitations/1
  # PATCH/PUT /invitations/1.json
  def update
    
    respond_to do |format|
      if @relation.update(relation_params)
        format.html { redirect_to @relation, notice: 'Invitation was successfully updated.' }
        format.json { render :show, status: :ok, location: @relation }
      else
        format.html { render :edit }
        format.json { render json: @relation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invitations/1
  # DELETE /invitations/1.json
  def destroy
    @relation.destroy
    respond_to do |format|
      format.html { redirect_to relations_url, notice: 'Invitation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_relation
      @relation = Relation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def relation_params
      params.require(:relation).permit(:marca,:modelo, :tipo, :descripcion_general, :item_id, :materia, :funcion, :ubicacion, :aplicacion, :observaciones)
    end
end
