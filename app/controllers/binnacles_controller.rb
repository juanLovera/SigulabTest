class BinnaclesController < ApplicationController
  before_action :set_binnacle, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  layout 'bootlayout'

  respond_to :html

  def index
    if params[:format]
      @binnacles = Binnacle.where(idSustancia: params[:format])  
    end
    @id = params[:format]
  end

  def show
    
  end

  def new
    binding.pry
    @id = params[:format]
    @binnacle = Binnacle.new    
  end

  def edit
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
    @binnacle.destroy
    respond_with(@binnacle)
  end

  private
    def set_binnacle
      @binnacle = Binnacle.find(params[:id])
    end

    def binnacle_params
      params.require(:binnacle).permit(:idSustancia, :fecha, :consumo, :ingreso, :saldo)
    end
end
