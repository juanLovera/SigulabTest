class ExecutionsController < ApplicationController
  layout 'bootlayout'

  def index
    @executions = Execution.all
    @sum = @executions.sum(:check_amount)
  end

  def show
    @execution = Execution.find(params[:id])
  end
  
  def new
    @execution = Execution.new
    if params[:cid]
      @commitment = Commitment.find(params[:cid])
      @execution.commitment_id = params[:cid]
    end
  end
  
  def create
    # Check Date
    unless params[:execution].nil?
      begin
        params[:execution][:check_elaboration_date] = DateTime.parse(params[:execution][:check_elaboration_date])
      rescue ArgumentError
        params[:execution][:check_elaboration_date] = nil
      end
    end
    
    @execution = Execution.new(execution_params)
    
    if @execution.save
      redirect_to action: 'index'
    else
      if params[:cid]
	    @commitment = Commitment.find(params[:cid])
	  end
      render 'new'
    end
  end
  
  def edit
    @execution = Execution.find(params[:id])
    @commitment = Commitment.find(Execution.find(params[:id]).commitment_id)    
  end
  
  def update
    # Check Date
    unless params[:execution].nil?
      begin
        params[:execution][:check_elaboration_date] = DateTime.parse(params[:execution][:check_elaboration_date])
      rescue ArgumentError
        params[:execution][:check_elaboration_date] = nil
      end
    end
    @execution = Execution.find(params[:id])
    @commitment = Commitment.find(Execution.find(params[:id]).commitment_id)    
    
    if @execution.update_attributes(execution_params)
      redirect_to action: 'index'
    else
      @commitment = Commitment.find(Execution.find(params[:id]).commitment_id)
      render 'edit'
    end
  end
  
  private
  
    def execution_params
      params.require(:execution).permit(:code, :commitment_id, :check_amount, :check_number, :check_elaboration_date, :check_sign_date, :check_delivery_date)
    end
    
    def purge_date(date)
      return date if date.blank?
      begin
        date = DateTime.parse(date)
      rescue ArgumentError
        return nil
      end
      return date
    end
  
end
