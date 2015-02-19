class ProjcommitmentsController < ApplicationController
  layout 'bootlayout'

  before_filter :authenticate_user!
  
  def list
    @commitments = Projcommitment.all.order("date ASC")
    @sum = @commitments.sum(:amount)
  end

  def show
    @commitment = Projcommitment.find(params[:id])
    @executions = Projexecution.where("commitment_id=?",params[:id])
    @sum = @executions.where("check_annulled=false").sum(:check_amount)
    @dif = @commitment.amount - @sum
    @size = @executions.count
  end

  def new
    @commitment = Projcommitment.new
    if params[:cid]
      @project = Project.find(params[:cid])
      @commitment.project_id = params[:cid]
    end    
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