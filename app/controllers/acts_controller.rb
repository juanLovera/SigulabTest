class ActsController < ApplicationController
  layout "application_compras"
  before_action :set_act, only: [:show, :edit, :update, :destroy]

  # GET /acts
  # GET /acts.json
  def index
    if current_user
    	@acts = Act.where(:user_id => current_user.username, :specification_id => session[:specification_sel_id]).all
      @sumActs = Act.where(:user_id => current_user.username, :specification_id => session[:specification_sel_id]).count
  	 end
respond_to do |format|
      format.html
      format.pdf do
               @act= Act.where(:user_id => current_user.username, :specification_id => session[:specification_sel_id]).first
		pdf = ReporteActs.new(@act)
      		  send_data pdf.render, filename: 'Acto_Motivado.pdf', type: 'application/pdf'
	      end
       format.xml do
              specification = Specification.find(session[:specification_sel_id])
       specification.p2 = 2
       specification.p3 = 2
       specification.p4 = 0
       specification.p5 = 2
       specification.p6 = 1
       session[:specification_p3] = specification.p3
    session[:specification_p2] = specification.p2
    session[:specification_p4] = specification.p4
    session[:specification_p5] = specification.p5
    session[:specification_p6] = specification.p6
    specification.save
              redirect_to "/acts?pdf=1"
      end
    end
  end

  # GET /acts/1
  # GET /acts/1.json
  def show
    @acts = Act.find(params[:id])
    
  end

  # GET /acts/new
  def new
    @act = Act.new
  end

  # GET /acts/1/edit
  def edit
  end

  # POST /acts
  # POST /acts.json
  def create
    @act = Act.new(act_params)
    @act.user_id = current_user.username
    @act.specification_id = session[:specification_sel_id]
   
    respond_to do |format|
      if @act.save
        format.html { redirect_to acts_url, notice: 'Act was successfully created.' }
        format.json { render :show, status: :created, location: @act }
      else
        format.html { render :new }
        format.json { render json: @act.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /acts/1
  # PATCH/PUT /acts/1.json
  def update
    respond_to do |format|
      if @act.update(act_params)
        format.html { redirect_to @act, notice: 'Act was successfully updated.' }
        format.json { render :show, status: :ok, location: @act }
      else
        format.html { render :edit }
        format.json { render json: @act.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /acts/1
  # DELETE /acts/1.json
  def destroy
    @act.destroy
    respond_to do |format|
      format.html { redirect_to acts_url, notice: 'Act was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_act
      @act = Act.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def act_params
      params.require(:act).permit(:numRegistro, :proveedor, :bienServicio, :tesis, :responsable, :justificacion, :providencia)
    end
end
