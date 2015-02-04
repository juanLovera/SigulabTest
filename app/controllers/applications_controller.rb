class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :edit, :update, :destroy]

  # GET /applications
  # GET /applications.json
  def index
    @applications = Application.all
    @sumSolicitudes = Application.all.count
  end

  # GET /applications/1
  # GET /applications/1.json
  def show
    @application = Application.find(params[:id])
    @equipos = Equipment.where(:solicitados => true)
    @instruments = Instrument.where(:solicitados => true)
    @tools = Tool.where(:solicitados => true)
    @consumables = Consumable.where(:solicitados => true)
    @sustancias = ChemicalSubstance.where(:solicitados => true)

    respond_to do |format|
      format.html
      format.pdf do
        pdf = SolicitudServicio.new(@application)
        send_data pdf.render, filename: 'SolicitudServicio.pdf', type: 'application/pdf'
      end
    end
    @equipment = Equipment.update_all(:solicitados => false)
    @instrumentos = Instrument.update_all(:solicitados => false)
    @herramientas = Tool.update_all(:solicitados => false)
    @consumibles = Consumable.update_all(:solicitados => false)
    @sustanciasqui = ChemicalSubstance.update_all(:solicitados => false)
  end

  # GET /applications/new
  def new
    binding.pry
    @lista
    @application = Application.new
    @equipment = Equipment.where(:solicitados => true).all.order('created_at DESC')
    @instruments = Instrument.where(:solicitados => true).all.order('created_at DESC')
    @tools = Tool.where(:solicitados => true).all.order('created_at DESC')
    @consumables = Consumable.where(:solicitados => true).all.order('created_at DESC')
    @sustancias = ChemicalSubstance.where(id2: params[:item_ids])
  end

  # GET /applications/1/edit
  def edit
  end

  # POST /applications
  # POST /applications.json
  def create
    @application = Application.new(application_params)

    respond_to do |format|
      if @application.save
        format.html { redirect_to @application, notice: 'La solicitud fue creada satisfactoriamente.' }
        format.json { render :show, status: :created, location: @application }
      else
        format.html { render :new }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /applications/1
  # PATCH/PUT /applications/1.json
  def update
    respond_to do |format|
      if @application.update(application_params)
        format.html { redirect_to @application, notice: 'La solicitud fue actualizada satisfactoriamente.' }
        format.json { render :show, status: :ok, location: @application }
      else
        format.html { render :edit }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applications/1
  # DELETE /applications/1.json
  def destroy
    @application.destroy
    respond_to do |format|
      format.html { redirect_to applications_url, notice: 'La solicitud fue eliminada satisfactoriamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def application_params
      params.require(:application).permit(:fechaRequerida, :descripcion, :uso)
    end
end
