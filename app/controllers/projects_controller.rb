class ProjectsController < ApplicationController
  layout 'bootlayout'

  def index
    @projects = Project.all.order("project_number ASC")
    # Total de monto en proyectos
    # Pendiente excluir proyectos anulados o finalizados
    @sum = @projects.sum(:amount)
  end

  def new
  	@project = Project.new
  end

  def create
    # Check Date
    unless params[:project].nil?
      begin
        params[:project][:incoming_date] = Date.parse(params[:project][:incoming_date])
      rescue ArgumentError
        params[:project][:incoming_date] = nil
      end
    end
    
    @project = Project.new(project_params)
    if @project.save
#      redirect_to action: 'index'
		redirect_to projects_path, notice: "The document has been uploaded."
    else
      render 'new'
    end
  end

  def show
    @project = Project.find(params[:id])
  end    

  def edit
    @project = Project.find(params[:id])
  end
  
  def update
    # Check Date
    unless params[:project].nil?
      begin
        params[:project][:incoming_date] = Date.parse(params[:project][:incoming_date])
      rescue ArgumentError
        params[:project][:incoming_date] = nil
      end
    end
    @project = Project.find(params[:id])
    
    if @project.update_attributes(project_params)
      redirect_to project_url(@project)
    else
      render 'edit'
    end
  end

  private
  
    def project_params
      params.require(:project).permit(:project_number, :contract, :title, :responsible, 
      	                              :admin, :sae_code, :amount, :equipments, :services, 
      	                              :infrastructure, :hhrr, :consumables, :incoming_date,
                     	              :status)
    end

end
