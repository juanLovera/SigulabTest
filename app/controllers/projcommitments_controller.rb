class ProjcommitmentsController < ApplicationController
  layout 'bootlayout'

  before_filter :authenticate_user!
  
  def list
    if params[:id]
      @project = Project.find(params[:id])
    end       
    @commitments = Projcommitment.order("date ASC").where("proj_id=?",params[:id])
    @sum = @commitments.sum(:amount)
  end

  def show
    @commitment = Projcommitment.all.find(params[:id])
    @executions = Projexecution.all.where("commitment_id=?",params[:id])
    @sum = @executions.where("check_annulled=false").sum(:check_amount)
    @dif = @commitment.amount - @sum
    @size = @executions.count
  end

  def new
    @commitment = Projcommitment.new
    if params[:id]
      @project = Project.find(params[:id])
      @commitment.proj_id = params[:id]
    end
    binding.pry
  end  

  def create
    # Check Date
    unless params[:projcommitment].nil?
      begin
        params[:projcommitment][:date] = Date.parse(params[:projcommitment][:date])
      rescue ArgumentError
        params[:projcommitment][:date] = nil
      end
    end
    
    @commitment = Projcommitment.new(commitment_params)
    
    if @commitment.save
      redirect_to action: 'list'
    else
      render 'new'
    end
  end



  def edit
    @commitment = Projcommitment.find(params[:id])
  end

  def update
    # Check Date
    unless params[:projcommitment].nil?
      begin
        params[:projcommitment][:date] = Date.parse(params[:projcommitment][:date])
      rescue ArgumentError
        params[:projcommitment][:date] = nil
      end
    end
    
    @commitment = Projcommitment.find(params[:id])
    
    if @commitment.update_attributes(projcommitment_params)
      redirect_to action: 'list'
    else
      render 'edit'
    end
  end  

  private
  
    def projcommitment_params
      params.require(:projcommitment).permit(:proj_id, :recipient, :amount, :description, :date, :code, :observations, :document)
    end
  
end  