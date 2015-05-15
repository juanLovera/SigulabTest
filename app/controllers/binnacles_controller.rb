class BinnaclesController < ApplicationController
  layout 'bootlayout'
  before_action :set_binnacle, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  responders :flash
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
    binding.pry
    @binnacle = Binnacle.new
    if params[:format]
      @id = params[:format]
    else
      @id = params[:formato]
    end
    @sustancias = ChemicalSubstance.where(id2: @id)

    @sustancias.each do |sustancia|
      @unidad = "#{sustancia.meassure}"
      @nombre = "#{sustancia.name}"
    end

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
    respond_to do |f|
      if @binnacle.save
        @ingresos = Binnacle.where(idSustancia: @binnacle.idSustancia).sum(:ingreso)
        @consumos = Binnacle.where(idSustancia: @binnacle.idSustancia).sum(:consumo)
        @binnacle.total = @ingresos - @consumos
        @binnacle.save
        f.html { redirect_to @binnacle }
        f.json { render :show, status: :created, location: @binnacle }
      else
        f.html { render :new }
        f.json { render json: @binnacle.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @binnacle.update(binnacle_params)
    respond_with(@binnacle)
  end

  def destroy
    @binnacle.destroy
    respond_with(@binnacle)
  end

  private
    def set_binnacle
      @binnacle = Binnacle.find(params[:id])
    end

    def binnacle_params
      params.require(:binnacle).permit(:idSustancia, :fecha, :tipo, :consumo, :ingreso, :descripcion, :total)
    end
end
