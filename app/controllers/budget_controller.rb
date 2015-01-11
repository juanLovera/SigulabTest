class BudgetController < ApplicationController
  layout 'bootlayout'
  
  before_action :set_subsystem 
  
  def index
  end
  
  def summary
    @labs = Lab.all
    @incomes = Income.all
    @commitments = Commitment.all

    @incomes_lab = []
    @commitments_lab = []
    @incomes_total = 0
    @commitments_total = 0
    @labs.each do |l|
      @incomes_lab[l.id] = @incomes.where(lab_id: l.id).sum(:amount)
      @incomes_total += @incomes_lab[l.id]
      @commitments_lab[l.id] = @commitments.where(lab_id: l.id).sum(:amount)
      @commitments_total += @commitments_lab[l.id]
    end
  end
  
  private
  
  def set_subsystem
    @subsystem = 'administracion'
  end
end
