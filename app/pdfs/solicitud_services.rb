# encoding: utf-8
class SolicitudServices < Prawn::Document

  def initialize (placeholder)
    print "INIT OK"
    @placeholder = placerholder
    super()
    encabezado
    pie_de_pagina
    titulo
    datos_de_solicitud
    datos_del_bien
    datos_del_proveedor
    firma
  end

  def encabezado
    bounding_box([bounds.left,bounds.top], :width => bounds.width) do
      #This inserts an image in the pdf file and sets the size of the image
      image "#{Rails.root}/app/assets/images/coord.jpg", width: 180, height: 90, :position => 0
      move_up 50
      image "#{Rails.root}/app/assets/images/Logo_ULab.jpg", width: 50, height: 55, :position => 490
    end
  end

  def pie_de_pagina
    bounding_box [bounds.left, bounds.bottom + 50], :width => bounds.width do
      font("#{Prawn::DATADIR}/fonts/DejaVuSans.ttf") do
        font_size 6
        text "Cod. Doc: UL01-M01F06    Fecha: 09/04/2015", :size => 6, :align => :left
      end
    end
  end

  def titulo
    bounding_box([bounds.left,bounds.top - 120], :width => bounds.width) do
      table info_titulo do
        row(0).font_style = :bold
        self.header = true
        self.row_colors = ['DDDDDD','DDDDDD']
        self.column_widths = [450,90]
      end
    end
  end

    def info_titulo
      [[{:content => "SOLICITUD DE SERVICIO", :rowspan => 2, :size => 20, :background_color => "DDDDDD" , :align => :center, :valign => :center  },
        {:content => "Registro No.", :background_color => "DDDDDD"}],
       [{:content => "1", :background_color => "FFFFFF", :align => :center}]]
    end

  def datos_de_solicitud
    bounding_box([bounds.left,bounds.top - 200], :width => bounds.width) do
      table info_solicitud do

      end
      table info_contacto do

      end
    end
  end

    def info_solicitud
      [[{:content => "PARA:", :background_color => "DDDDDD" , :align => :left, :valign => :center  },
        {:content => "DE:", :background_color => "DDDDDD", :align => :left, :valign => :center},
        {:content => "FECHA:",:background_color => "DDDDDD", :align => :left, :valign => :center}],

       [{:content => "Coordinación de Adquiciciones - ULab", :background_color => "FFFFFF", :align => :center, :valign => :center},
        {:content => "Empresa", :background_color => "FFFFFF", :align => :center, :valign => :center},
        {:content => "Fecha", :background_color => "FFFFFF", :align => :center, :valign => :center}]]
    end

    def info_contacto
      [[{:content => "Persona Contacto de la Unidad Solicitante", :background_color => "DDDDDD" , :align => :left, :valign => :center  },
        {:content => "E-mail", :background_color => "DDDDDD", :align => :left, :valign => :center},
        {:content => "Télefono",:background_color => "DDDDDD", :align => :left, :valign => :center}],

       [{:content => "Nombre Encargado", :background_color => "FFFFFF", :align => :center, :valign => :center},
        {:content => "Correo", :background_color => "FFFFFF", :align => :center, :valign => :center},
        {:content => "#Telefono", :background_color => "FFFFFF", :align => :center, :valign => :center}]]
    end

  def datos_del_bien
    [[{:content => "DATOS DEL BIEN(OBJETO DEL SERVICIO)", :background_color => "DDDDDD" , :align => :left, :valign => :center  }],

        [{:content => "NOMBRE", :background_color => "DDDDDD" , :align => :left, :valign => :center  },
      {:content => "No. Bien Nacional", :background_color => "DDDDDD", :align => :left, :valign => :center},
      {:content => "UBICACIÓN FÍSICA",:background_color => "DDDDDD", :align => :left, :valign => :center}],

     [{:content => "Nombre", :background_color => "FFFFFF", :align => :center, :valign => :center},
      {:content => "Numero", :background_color => "FFFFFF", :align => :center, :valign => :center},
      {:content => "Ubicacion", :background_color => "FFFFFF", :align => :center, :valign => :center}],

     [{:content => "DESCRIPCIÓN DETALLADA DEL SERVICIO", :background_color => "DDDDDD" , :align => :left, :valign => :center  }],
    [ {:content => "Descripcion", :background_color => "FFFFFF", :align => :center, :valign => :justify}]]
  end

  def datos_del_proveedor
    [[{:content => "DATOS DEL PROVEEDOR DE SERVICIO", :background_color => "DDDDDD" , :align => :left, :valign => :center  }],

     [{:content => "Compañía", :background_color => "DDDDDD" , :align => :left, :valign => :center  },
      {:content => "RIF", :background_color => "DDDDDD", :align => :left, :valign => :center}],

     [{:content => "Nombre", :background_color => "FFFFFF", :align => :center, :valign => :center},
      {:content => "Numero", :background_color => "FFFFFF", :align => :center, :valign => :center},],

     [{:content => "Persona Contacto", :background_color => "DDDDDD" , :align => :left, :valign => :center  },
      {:content => "e-mail", :background_color => "DDDDDD", :align => :left, :valign => :center},
      {:content => "Télefono",:background_color => "DDDDDD", :align => :left, :valign => :center}],

     [{:content => "Nombre", :background_color => "FFFFFF", :align => :center, :valign => :center},
      {:content => "correo", :background_color => "FFFFFF", :align => :center, :valign => :center},
      {:content => "numero", :background_color => "FFFFFF", :align => :center, :valign => :center}],

     [{:content => "Referencia de Cotización", :background_color => "DDDDDD" , :align => :left, :valign => :center  }],

     [{:content => "Fecha", :background_color => "DDDDDD" , :align => :left, :valign => :center  },
      {:content => "No.", :background_color => "DDDDDD", :align => :left, :valign => :center},
      {:content => "Monto Total del Servicio (Bs.):",:background_color => "DDDDDD", :align => :left, :valign => :center}],

     [{:content => "Fecha", :background_color => "FFFFFF", :align => :center, :valign => :center},
      {:content => "Numero", :background_color => "FFFFFF", :align => :center, :valign => :center},
      {:content => "Costo", :background_color => "FFFFFF", :align => :center, :valign => :center}]]
  end

  def firma
    [   [{:content => "OBSERVACIONES", :background_color => "DDDDDD" , :align => :left, :valign => :center  },
         {:content => "Firma y Sello", :background_color => "DDDDDD", :align => :left, :valign => :center}],

        [{:content => "", :background_color => "FFFFFF", :align => :center, :valign => :center},
         {:content => "", :background_color => "FFFFFF", :align => :center, :valign => :center},],

        [{:content => "Por la Coordinación de Adquisiciones", :background_color => "DDDDDD" , :align => :left, :valign => :center  },
         {:content => "Aprobado por:", :background_color => "DDDDDD", :align => :left, :valign => :center}],

        [ subaccionpartida,
          firmacoordinacion,
          firmadireccion  ]]


  end

    def subaccionpartida
    [    [{:content => "SUB-ACCION ESPECIFICA (SAE)", :background_color => "DDDDDD", :align => :center, :valign => :center}],
         [{:content => "", :background_color => "FFFFFF", :align => :center, :valign => :center}],
         [{:content => "PARTIDA", :background_color => "DDDDDD", :align => :center, :valign => :center}],
         [{:content => "", :background_color => "FFFFFF", :align => :center, :valign => :center}]]
    end

    def firmacoordinacion
    [   [{:content => "Lic. Thaylin Villa\nCoordinadora de Adquisiciones", :background_color => "FFFFFF", :align => :center, :valign => :bottom}],
        [{:content => "Fecha", :background_color => "FFFFFF", :align => :left, :valign => :center}]]
    end

    def firmadireccion
    [   [{:content => "Prof. Wilfrido Gonzalez\nDirector - Lab", :background_color => "FFFFFF", :align => :center, :valign => :bottom}],
        [{:content => "Fecha", :background_color => "FFFFFF", :align => :left, :valign => :center}]]
    end

end