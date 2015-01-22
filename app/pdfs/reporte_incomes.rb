# encoding: utf-8
class ReporteIncomes < Prawn::Document

  def initialize(incomes)
  	super :page_layout => :landscape
  	header
    info
    @incomes = incomes
  end
 
  def header
  	y_position = cursor - 40
    image "#{Rails.root}/app/assets/images/cebolla.png", width: 50, :at => [75, cursor]
	bounding_box([0, y_position], :width => 200, :height => 40) do
      text "UNIVERSIDAD SIMÓN BOLÍVAR", size: 8, style: :bold, :align => :center
      text "Dirección de Finanzas - Oficina de Presupuesto", size: 8, :align => :center
      text "Comisión de Planificación y Desarrollo", size: 8, :align => :center
	end
  end

  def info
#    define_grid(:columns => 6, :rows => 25, :gutter => 5)
#    grid(4,0).show
#    grid(4,1).show
#    grid(5,0).show
#    grid(5,1).show
#    grid(6,0).show
#    grid(6,1).show    
#    grid(7,0).show
#    grid(7,1).show

    data = [ ["AÑO:", "2014"],     #  Obtener año de sistema
           ["MES:", "Diciembre"],  # Obtener mes de sistema
           ["UNIDAD EJECUTORA:", "Unidad de Laboratorios"], 
           ["RESPONSABLE DE LA UNIDAD", "Prof. José Gregorio Ruiz Camacho"]
           ]
    table(data)
  end
  
  def product_rows
    [['#', 'Name', 'Price']] +
      @products.map do |product|
      [product.id, product.name, product.price]
    end
  end

end
