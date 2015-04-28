class RequisitionsController < ApplicationController
  layout "application_compras"
  respond_to :html, :xml, :json
  before_action :set_requisition, only: [:show, :edit, :update, :destroy]

  # GET /requisitions
  # GET /requisitions.json
  def index
    if current_user
    	@requisitions = Requisition.where(:user_id => current_user.username, :specification_id => session[:specification_sel_id]).first
      @sumRequisition = Requisition.where(:user_id => current_user.username, :specification_id => session[:specification_sel_id]).count
     respond_to do |format|
	      format.html do
          if @sumRequisition != 0
            redirect_to @requisitions
          end
        end
        format.pdf do
		
		redirect_to @requisitions.attachment
	      end
	      format.xml do
              specification = Specification.find(session[:specification_sel_id])
	       specification.p6 = 2
	    session[:specification_p6] = specification.p6
	    specification.save
              redirect_to "/requisitions/#{@requisitions.id}?pdf=1"
      end
      end
    end
  end

  # GET /requisitions/1
  # GET /requisitions/1.json
  def show
    @requisition = Requisition.find(params[:id])

  end

  # GET /requisitions/new
  def new
    @requisition = Requisition.new
  end

  # GET /requisitions/1/edit
  def edit
  end

  # POST /requisitions
  # POST /requisitions.json
  def create
    @requisition = Requisition.new(requisition_params)
    @requisition.user_id = current_user.username
    @requisition.specification_id = session[:specification_sel_id]
    respond_to do |format|
      if @requisition.save
        format.html { redirect_to @requisition, notice: 'Requisition was successfully created.' }
        format.json { render :show, status: :created, location: @requisition }
      else
        format.html { render :new }
        format.json { render json: @requisition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requisitions/1
  # PATCH/PUT /requisitions/1.json
  def update
    respond_to do |format|
      if @requisition.update(requisition_params)
        format.html { redirect_to @requisition, notice: 'Requisition was successfully updated.' }
        format.json { render :show, status: :ok, location: @requisition }
      else
        format.html { render :edit }
        format.json { render json: @requisition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requisitions/1
  # DELETE /requisitions/1.json
  def destroy
    @requisition.destroy
    respond_to do |format|
      format.html { redirect_to requisitions_url, notice: 'Requisition was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_requisition
      @requisition = Requisition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def requisition_params
      params.require(:requisition).permit(:solicitante, :consumidor, :partida, :autor, :observacion, :attachment)
    end
end
