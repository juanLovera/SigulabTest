class ProjectsController < ApplicationController
  layout 'bootlayout'

  before_filter :authenticate_user!

  def index
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

    # Default status depending on incoming_date
    if params[:project][:incoming_date].nil?
      params[:project][:status] = 0
    else
      params[:project][:status] = 1
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
           
          if (params[:project][:incoming_date] == nil)
            @project_anulled = Project.find(params[:id])            
            params[:project][:incoming_date] = @project_anulled.incoming_date
          else
            params[:project][:incoming_date] = Date.parse(params[:project][:incoming_date])
          end
        rescue ArgumentError
          params[:project][:incoming_date] = nil
        end
      end

      @project = Project.find(params[:id])

      if params[:project][:incoming_date].nil? && (not (params[:project][:status] == "pending"))      
        @project.incoming_date_required
        render 'edit'
      else 
          if params[:project][:annulled_date] == "" && params[:project][:status] == "annulled"
            params[:project][:annulled_date] = nil
            @project.annulled_date_required
            render 'edit'
          else
            if @project.update_attributes(project_params)
              redirect_to project_url(@project)
            else
              render 'edit'
            end
          end
        end
      end

def list
  @projects = Project.all.order("project_number ASC")
  @sum = @projects.where("NOT(status=3) AND NOT(status=4)").sum(:amount)  
end

  private
  
    def project_params
      params.require(:project).permit(:project_number, :contract, :title, :responsible, 
      	                              :admin, :sae_code, :amount, :equipments, :services, 
      	                              :infrastructure, :hhrr, :consumables, :incoming_date,
                     	                :status, :other_desc, :other_amount, :annulled_date,
                                      :observation, :num_cuenta, :banco)
    end

end
