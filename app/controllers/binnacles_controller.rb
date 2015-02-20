class BinnaclesController < ApplicationController
  before_action :set_binnacle, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  layout 'bootlayout'

  respond_to :html

  def index
    if params[:format]
      @binnacles = Binnacle.where(idSustancia: params[:format])
      @ingresos = Binnacle.where(idSustancia: params[:format]).sum(:ingreso)
      @consumos = Binnacle.where(idSustancia: params[:format]).sum(:consumo)
    end
    @sustancias = ChemicalSubstance.where(id2: params[:format])
    @sustancias.each do |sustancia|
      @unidad = "#{sustancia.meassure}"
    end
    @total = @ingresos - @consumos
    @id = params[:format]
  end

  def show
    @id = @binnacle.idSustancia
    @sustancias = ChemicalSubstance.where(id2: @id)
    @sustancias.each do |sustancia|
      @unidad = "#{sustancia.meassure}"
    end
  end

  def new
    @sustancias = ChemicalSubstance.where(id2: params[:format])
    @sustancias.each do |sustancia|
      @unidad = "#{sustancia.meassure}"
      @nombre = "#{sustancia.name}"
    end
    @id = params[:format]
    @binnacle = Binnacle.new
  end

  def edit
    @id = @binnacle.idSustancia
    @sustancias = ChemicalSubstance.where(id2: @id)
    @sustancias.each do |sustancia|
      @unidad = "#{sustancia.meassure}"
    end
  end

  def create
    @binnacle = Binnacle.new(binnacle_params)
    flash[:notice] = 'El registro en la bitácora ha sido exitoso.' if @binnacle.save
    respond_with(@binnacle)
        
  end

  def update
    flash[:notice] = 'La bitácora se ha actualizado exitosamente.' if @binnacle.update(binnacle_params)
    respond_with(@binnacle)
  end

  def destroy
    @id = @binnacle.idSustancia
    @binnacle.destroy
    respond_with(@id)
  end

  private
    def set_binnacle
      @binnacle = Binnacle.find(params[:id])
    end

    def binnacle_params
      params.require(:binnacle).permit(:idSustancia, :fecha, :tipo, :consumo, :ingreso, :descripcion)
    end
end
