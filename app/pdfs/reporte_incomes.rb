# encoding: utf-8
class ReporteIncomes < Prawn::Document

  def initialize(insumes)
  	super :page_layout => :landscape
  	header
  	text_content
    @products = insumes
  end
 
  def header
  	y_position = cursor - 40
    image "#{Rails.root}/app/assets/images/cebolla.png", width: 50
	bounding_box([0, y_position], :width => 200, :height => 200) do
      text "UNIVERSIDAD SIMÓN BOLÍVAR", size: 8, style: :bold
      text "Dirección de Finanzas - Oficina de Presupuesto", size: 8
      text "Comisión de Planificación y Desarrollo", size: 8
	end
  end
  
  def product_rows
    [['#', 'Name', 'Price']] +
      @products.map do |product|
      [product.id, product.name, product.price]
    end
  end

end
