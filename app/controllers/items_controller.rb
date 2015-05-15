class ItemsController < ApplicationController
  layout "application_compras"
  respond_to :html, :xml, :json
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    if current_user
   	 @items = Item.where(:specification_id => session[:specification_sel_id]).all
     	@sumItem = Item.where(:specification_id => session[:specification_sel_id]).count
    end
    specification = Specification.find(session[:specification_sel_id])
    if specification.user_id == current_user.username
		@propio = true
	else
		@propio = false
	end
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ReporteItems.new(@items, specification)
        nombre = "Especificacion_#{session[:specification_sel_id]}.pdf"
        send_data pdf.render, filename: nombre, type: 'application/pdf'
      end
      format.xml do
      specification.p1 = 2
        specification.p2 = 1
        specification.save
        session[:specification_p2] = 1
        session[:specification_p1] = 2
      redirect_to "/items?pdf=1"
      end

    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
	specification = Specification.find(session[:specification_sel_id])
    if specification.user_id == current_user.username
		@propio = true
	else
		@propio = false
	end
	if current_user.quality? 
		@user = User.where(:username => current_user.username).first
		if @user.quality? || @user.quality_analist?
			@propio = true
		end
	end
	if current_user.manage? 
		@user = User.where(:username => current_user.username).first
		if @user.manage? || @user.manage_analist?
			@propio = true
		end
	end
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.username

    respond_to do |format|
      if @item.save

        format.html { redirect_to items_url, notice: 'Se ha creado el item exitosamente.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:nombre, :tipo, :descripcion, :dimensiones_largo, :dimensiones_alto, :dimensiones_ancho, :cantidad, :unidad_ancho, :unidad_largo, :unidad_alto, :specification_id)
    end
end
