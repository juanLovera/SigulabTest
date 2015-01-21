class IncomesController < ApplicationController
  layout 'bootlayout'

  def index
    @incomes = Income.all.order("date ASC")
    @sum = @incomes.sum(:amount)
  end

  def show
    @income = Income.find(params[:id])
  
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ReporteIncomes.new(@income)
        send_data pdf.render, filename: 'MOD-01.pdf', type: 'application/pdf'
      end
    end
  end
  
  def new
    @income = Income.new
    @labs = Lab.all
  end
  
  def create
    # Check Date
    unless params[:income].nil?
      begin
        params[:income][:date] = Date.parse(params[:income][:date])
      rescue ArgumentError
        params[:income][:date] = nil
      end
    end
    
    @income = Income.new(income_params)
  
    if @income.save
#      redirect_to action: 'index'
		redirect_to incomes_path, notice: "The document has been uploaded."

    else
      @labs = Lab.all
      render 'new'
    end
  end
  
  def edit
    @income = Income.find(params[:id])
    @labs = Lab.all
  end
  
  def update
    # Check Date
    unless params[:income].nil?
      begin
        params[:income][:date] = Date.parse(params[:income][:date])
      rescue ArgumentError
        params[:income][:date] = nil
      end
    end
    @income = Income.find(params[:id])
    
    if @income.update_attributes(income_params)
      redirect_to income_url(@income)
    else
      @labs = Lab.all
      render 'edit'
    end
  end
  
  private
  
    def income_params
      params.require(:income).permit(:lab_id, :sae_code, :origin, :amount, :description, :date, :organism, :document, :financing, :doc_code, :doc_date, :unit, :variation, :resource, :resource_description)
    end
  
end
