# encoding: utf-8
class ReporteBudget < Prawn::Document

  def initialize(labs,incomes,commitments,executions)
  	super :page_layout => :landscape
  	@labs = labs
  	@incomes = incomes
  	@commitments = commitments
  	@executions = executions
  	header
    date_title
    table1
    table2
    footer
  end
 
  def header
  	y_position = cursor - 40
    image "#{Rails.root}/app/assets/images/cebolla.png", width: 55, :at => [75, cursor]
	  bounding_box([0, y_position], :width => 200, :height => 40) do
      text "UNIVERSIDAD SIMÓN BOLÍVAR", size: 10, style: :bold, :align => :center
      text "VICERRECTORADO ACADÉMICO", size: 9, :align => :center
      text "UNIDAD DE LABORATORIOS", size: 8, :align => :center
	end
  end

  def date_title
  	move_down 10
  	text "#{Date.today.strftime("%d")}/#{Date.today.strftime("%m")}/#{Time.now.year}", size: 10, :align => :right
    move_down 20
  	text "RESUMEN PRESUPUESTARIO", size: 12, :align => :center, style: :bold
    move_down 30  	
  end

  def table1
    table(content1, :position => 23, :width => 700, :cell_style => {:align => :center, :size => 10}) do
      row(0).background_color = "C0C0C0"
    end   
    move_down 20    
  end

  def content1

  	@incomes_total = 0
  	@commitments_total = 0  	
  	@executions_total = 0  	

  	[ ["Dependencia", "Monto Asignado", "Monto Comprometido", "Monto Ejecutado", "Saldo Disponible"] ] + 

  	@labs.map do |lab|

  		@incomes_lab = @incomes.where(lab_id: lab.id).sum(:amount)
  		@incomes_total += @incomes_lab

  		@commitments_lab = @commitments.where(lab_id: lab.id).sum(:amount)
  		@commitments_total += @commitments_lab

  		@executions_commitement = @executions.where(commitment_id: lab.id).where("check_annulled=false").sum(:check_amount)
  		@executions_total += @executions_commitement

  		[lab.sae_name,@incomes_lab,@commitments_lab,@executions_commitement,@incomes_lab-@commitments_lab]
  	end
  end

  def table2
    move_down 10  	
    table(content2, :position => 23, :width => 700, :cell_style => {:align => :center, :size => 10}) do
      row(0).background_color = "C0C0C0"
      column(0).width = 137
    end   
    move_down 20    
  end

  def content2
  	[ ["", "Monto Asignado", "Monto Comprometido", "Monto Ejecutado", "Saldo Disponible"] ] + 
  	[ ["TOTALES",@incomes_total,@commitments_total,@executions_total,@incomes_total-@commitments_total] ]
  end

  def footer
    move_down 65
      text "Universidad Simón Bolívar, Edif. Energética, Planta Baja. Valle de Sartenejas, Baruta, Caracas, Edo. Miranda, Venezuela, 89000", size: 9, :align => :center
      text "Telef.: 58 212 906-3708 / 3709 / 3710 / 3711 Fax: 58 212 906-3712 www.ulab.usb.ve", size: 9, :align => :center      

  end
  
  def product_rows
    [['#', 'Name', 'Price']] +
      @products.map do |product|
      [product.id, product.name, product.price]
    end
  end

end

