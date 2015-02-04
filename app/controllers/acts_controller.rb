class ActsController < ApplicationController
  layout "application_compras"
  before_action :set_act, only: [:show, :edit, :update, :destroy]

  # GET /acts
  # GET /acts.json
  def index
    if current_user
    	@acts = Act.where(:user_id => current_user.username).all
      @sumActs = Act.where(:user_id => current_user.username).count
  	 end
  end

  # GET /acts/1
  # GET /acts/1.json
  def show
    @acts = Act.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ReporteActs.new(@act)
        send_data pdf.render, filename: 'Acto_Motivado.pdf', type: 'application/pdf'
      end
    end
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

    respond_to do |format|
      if @act.save
        format.html { redirect_to @act, notice: 'Act was successfully created.' }
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
