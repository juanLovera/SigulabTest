class ApplicationsController < ApplicationController
  layout 'bootlayout'
  before_filter :authenticate_user!
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
    @equipment = Equipment.where(id2: params[:item_ids])
    @instruments = Instrument.where(id2: params[:item_ids])
    @tools = Tool.where(id2: params[:item_ids])

    respond_to do |format|
      format.html
      format.pdf do
        pdf = SolicitudServicio.new(@application)
        send_data pdf.render, filename: 'SolicitudServicio.pdf', type: 'application/pdf'
      end
    end
  end

  # GET /applications/new
  def new
    @application = Application.new
    @equipment = Equipment.where(id2: params[:item_ids])
    @instruments = Instrument.where(id2: params[:item_ids])
    @tools = Tool.where(id2: params[:item_ids])

    @sumE = Equipment.where(id2: params[:item_ids]).count
    @sumI = Instrument.where(id2: params[:item_ids]).count
    @sumT = Tool.where(id2: params[:item_ids]).count
  end

  # GET /applications/1/edit
  def edit
  end

  # POST /applications
  # POST /applications.json
  def create
    @application = Application.new(application_params)
    @equipment = Equipment.where(id2: params[:item_ids])
    @instruments = Instrument.where(id2: params[:item_ids])
    @tools = Tool.where(id2: params[:item_ids])

    respond_to do |format|
      if @application.save

        @equipment.each do |equipment|
          @servicio = ServiceItems.new
          @servicio.servicio = @application.id.to_s
          @servicio.item = equipment.id2
        end

        @instruments.each do |instrument|
          @servicio = ServiceItems.new
          @servicio.servicio = @application.id.to_s
          @servicio.item = instrument.id2
        end

        @tools.each do |tool|
          @servicio = ServiceItems.new
          @servicio.servicio = @application.id.to_s
          @servicio.item = tool.id2
        end

        format.html { redirect_to @application, notice: 'La solicitud fue creada satisfactoriamente.', :item_ids => params[:item_ids] }
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
