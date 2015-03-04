class LoansController < ApplicationController
  before_action :set_loan, only: [:show, :edit, :update, :destroy, :item_ids]
  layout 'bootlayout'
  before_filter :authenticate_user!
  # GET /loans
  # GET /loans.json
  def index
    @loans = Loan.all
    @sumSolicitudes = Loan.all.count
  end

  # GET /loans/1
  # GET /loans/1.json
  def show
    @loan = Loan.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = SolicitudPrestamo.new(@loan)
        send_data pdf.render, filename: 'SolicitudPrestamo.pdf', type: 'application/pdf'
      end
    end
  end

  # GET /loans/new
  def new
    if params[:item_ids] == nil
      flash[:notice] = "No ha seleccionado ningun item para ser prestado"
      redirect_to :back
    else
      @loan = Loan.new
      @equipment = Equipment.where(id2: params[:item_ids])
      @instruments = Instrument.where(id2: params[:item_ids])
      @tools = Tool.where(id2: params[:item_ids])
      @consumables = Consumable.where(id2: params[:item_ids])
      @sustancias = ChemicalSubstance.where(id2: params[:item_ids])
    end
  end

  # GET /loans/1/edit
  def edit
  end

  # POST /loans
  # POST /loans.json
  def create
    @loan = Loan.new(loan_params)
    
    respond_to do |format|
      if @loan.save
        format.html { redirect_to @loan, notice: 'Se ha creado exitosamente la solicitud de préstamo.' }
        format.json { render :show, status: :created, location: @loan }
      else
        format.html { render :new }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /loans/1
  # PATCH/PUT /loans/1.json
  def update
    respond_to do |format|
      if @loan.update(loan_params)
        format.html { redirect_to @loan, notice: 'Se ha actualizado exitosamente la solicitud de préstamo.' }
        format.json { render :show, status: :ok, location: @loan }
      else
        format.html { render :edit }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loans/1
  # DELETE /loans/1.json
  def destroy
    @loan.destroy
    respond_to do |format|
      format.html { redirect_to loans_url, notice: 'Se ha eliminado exitosamente la solicitud de préstamo.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loan
      @loan = Loan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def loan_params
      params.require(:loan).permit(:fechaEntrega, :ubicacion, :fechaTope, :condiciones, :medida)
    end
end
