class EquipmentController < ApplicationController
  before_action :authenticate_user!
  before_action :set_equipment, only: [:show, :edit, :update, :destroy]

  # GET /equipment
  # GET /equipment.json
  def index
	if params[:search]
		@equipment_all = Equipment.search(params[:search])
		@equipment = Equipment.where(:showable => true).search(params[:search])
	else
		@equipment_all = Equipment.where(:showable => true).all.order('created_at DESC')
		@equipment = Equipment.all.order('created_at DESC')
	end
  end

  # GET /equipment/1
  # GET /equipment/1.json
  def show
  end

  # GET /equipment/new
  def new
    @equipment = Equipment.new
  end

  # GET /equipment/1/edit
  def edit
  end

  # POST /equipment
  # POST /equipment.json
  def create
    @equipment = Equipment.new(equipment_params)

    respond_to do |format|
      if @equipment.save
        format.html { redirect_to @equipment, notice: 'El equipo fue creado de forma exitosa.' }
        format.json { render :show, status: :created, location: @equipment }
      else
        format.html { render :new }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /equipment/1
  # PATCH/PUT /equipment/1.json
  def update
    respond_to do |format|
      if @equipment.update(equipment_params)
        format.html { redirect_to @equipment, notice: 'El equipo fue actualizado de forma exitosa.' }
        format.json { render :show, status: :ok, location: @equipment }
      else
        format.html { render :edit }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equipment/1
  # DELETE /equipment/1.json
  def destroy
    @equipment.destroy
    respond_to do |format|
      format.html { redirect_to equipment_index_url, notice: 'El equipo fue eliminado de forma exitosa.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_equipment
      @equipment = Equipment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def equipment_params
      params.require(:equipment).permit(:name, :brand, :model, :serial, :national_good, :status, :last_calibration, :length, :depth, :width, :measurelength,:measuredepth,:measurewidth, :responsible, :location, :adquisition_date, :buy_order, :cost, :bill, :investigation, :teaching, :extention, :management, :calibrated, :showable, :dependency)
    end
end
