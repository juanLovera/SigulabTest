# encoding: utf-8
class ReporteActs < Prawn::Document

	def initialize(act)
		super()
		@act = act
		repeat :all do
			header
			pie_de_pagina
		end
		titulo
    	encabezado
    	texto

	end

	def header
	    #This inserts an image in the pdf file and sets the size of the image
	    image "#{Rails.root}/app/assets/images/coord.jpg", width: 180, height: 90, :position => 0
	    move_up 50
	    image "#{Rails.root}/app/assets/images/Logo_ULab.jpg", width: 50, height: 55, :position => 490  

	end

	def pie_de_pagina
	    font("#{Prawn::DATADIR}/fonts/DejaVuSans.ttf") do 
	      font_size 8
	      text_box "Universidad Simón Bolívar, Edif. Energética, Planta Baja. Valle de Sartenejas, Baruta, " +
	                "Caracas, Edo. Miranda, Venezuela, 89000", :at => [20,11], :height => 8
	      font_size 7
	      text_box "Telef.: +58 212 906-3708 / 3709 / 3710 / 3711  Fax: +58 212 906-3712", :at => [150,0], :height => 7
	    end
	    
	end

	def titulo
	   move_down 13
	   table tittle do
	      row(0).font_style = :bold
	      self.header = true
	      self.row_colors = ['DDDDDD','DDDDDD']
	      self.column_widths = [450,90]
	    end
	  end

	 def tittle 
	      [[{:content => "Acto Motivado", :rowspan => 2, :size => 20, :background_color => "DDDDDD", :align => :center, :height => 20},
	        {:content => "Registro:", :background_color => "DDDDDD", :height => 18, :size => 9, :align => :center}],
	        [{:content => "#{@act.id}", :background_color => "FFFFFF",:height => 18, :size => 9, :align => :center}]]

	    
	  end

	  def encabezado
	 	 draw_text "Sartenejas, #{Time.now.strftime("%d-%m-%Y")}", :at => [415, 540]
	  end

	  def texto

	  	move_down 58

	  	text "Sirva la presente como ACTO MOTIVADO en relación a la "+
	  		 "adquisición, por parte de la Unidad de Laboratorios " +
	  		 "a #{@act.proveedor}, de acuerdo a la cotización anexa, " +
	  		 "de #{@act.bienServicio}, el (los) cual(es) es (son) requerido(s) " +
	  		 "para #{@act.tesis}, bajo la responsabilidad de #{@act.responsable}.\n\n" +
	  		 "Dicha solicitud obedece a que #{@act.justificacion}.\n\n" +
	  		 "En tal sentido, es necesario realizar la adjudicación de compra directa a la empresa " +
	    	 "#{@act.proveedor}, a los fines de darle continuidad a los objetivos planteados.\n\n" +
	    	 "Es importante señalar que los recursos para cubrir la adquisición de #{@act.bienServicio} " +
	    	 "provienen de #{@act.providencia}, cuya cuenta es manejada a través de la administración de " +
	    	 "la Unidad de Laboratorios.\n\n" +
	    	 "Por todo lo anterior, estamos convencidos que esta es una compra razonable en sus costos, " +
	    	 "calidad, experiencia de uso y adaptadas a las necesidades.\n\n",
	  		 :align => :justify, :indent_paragraphs => 45, :inline_format => true, :size => 13


	    text "Atentamente\n\n\n\n", :align => :center, :inline_format => true, :size => 13


	    text "#{@act.responsable}\n\n\n", :align => :center, :inline_format => true, :size => 13


	    text "VoBo\n\n\n\n", :align => :left, :inline_format => true, :size => 13


	    text "Lic. Thailyn Villa,\nCoordinación de Adquisiciones",
	    	 :align => :left, :inline_format => true, :size => 13

	    draw_text "Cod. Doc.: UL01-M01F03     Fecha: #{Time.now.strftime("%d-%m-%Y")}", :size => 6, :at => [1,20]


	  end

end
