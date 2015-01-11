class ItemsController < ApplicationController
  layout "application_compras"
  respond_to :html, :xml, :json
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    if current_user
   	 @items = Item.where(:user_id => current_user.username).all
     @sumItem = Item.where(:user_id => current_user.username).count
    end
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ReporteItems.new(@items)
        send_data pdf.render, filename: 'report.pdf', type: 'application/pdf'
      end
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
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

        format.html { redirect_to @item, notice: 'Se ha creado el item exitosamente.' }
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
      params.require(:item).permit(:nombre, :tipo, :descripcion, :dimensiones, :cantidad, :unidad)
    end
end
