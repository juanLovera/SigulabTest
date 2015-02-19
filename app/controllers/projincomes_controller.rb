class ProjincomesController < ApplicationController
  layout 'bootlayout'

  before_filter :authenticate_user!

  def index
    @projincomes = Projincome.all.order("date ASC")
    @sum = @projincomes.sum(:amount)
  end

  def show
    @projincome = Projincome.find(params[:id])  
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ReporteIncomes.new(@projincome)
        send_data pdf.render, filename: 'MOD-01.pdf', type: 'application/pdf'
      end
    end
  end
  
  def new
    @projincome = Projincome.new
  end
  
  def create
    # Check Date
    unless params[:projincome].nil?
      begin
        params[:projincome][:date] = Date.parse(params[:projincome][:date])
      rescue ArgumentError
        params[:projincome][:date] = nil
      end
    end

    if params[:projincome][:resource] == ""
    	params[:projincome][:resource] = 0
    end
    
    if params[:income][:document] != nil
      archivo = params[:projincome][:document];
      #Nombre original del archivo.
      nombre = archivo.original_filename;
      #Directorio donde se va a guardar.
      directorio = "public/archivos/";
      #Extensión del archivo.
      extension = nombre.slice(nombre.rindex("."), nombre.length).downcase;
      #Ruta del archivo.
      path = File.join(directorio, nombre);
      #Crear en el archivo en el directorio. Guardamos el resultado en una variable, será true si el archivo se ha guardado correctamente.
      resultado = File.open(path, "wb") { |f| f.write(archivo.read) };
      #Verifica si el archivo se subió correctamente.
      if resultado
        subir_archivo = "ok";
      else
        subir_archivo = "error";
      end
    end
    
    @projincome = Projincome.new(projincome_params)
  
    if @Projincome.save
#      redirect_to action: 'index'
		  redirect_to projincomes_path, notice: "The document has been uploaded."
    else
      @labs = Lab.all
      render 'new'
    end
  end
  
  def edit
    @projincome = Projincome.find(params[:id])
  end
  
  def update
    # Check Date
    unless params[:projincome].nil?
      begin
        params[:projincome][:date] = Date.parse(params[:projincome][:date])
      rescue ArgumentError
        params[:projincome][:date] = nil
      end
    end

    if params[:projincome][:resource] == ""
    	params[:projincome][:resource] = 0
    end

    if (params[:projincome][:document] != nil)
      archivo = params[:projincome][:document];
      #Nombre original del archivo.
      nombre = archivo.original_filename;
      #Directorio donde se va a guardar.
      directorio = "public/archivos/";
      #Extensión del archivo.
      extension = nombre.slice(nombre.rindex("."), nombre.length).downcase;
      #Ruta del archivo.
      path = File.join(directorio, nombre);
      #Crear en el archivo en el directorio. Guardamos el resultado en una variable, será true si el archivo se ha guardado correctamente.
      resultado = File.open(path, "wb") { |f| f.write(archivo.read) };
      #Verifica si el archivo se subió correctamente.
      if resultado
        subir_archivo = "ok";
      else
        subir_archivo = "error";
      end
    end



    @projincome = Projincome.find(params[:id])
  
    if @Projincome.update_attributes(projincome_params)
      redirect_to income_url(@projincome)
    else
      @labs = Lab.all
      render 'edit'
    end
  end
  
  private
  
    def projincome_params
      params.require(:projincome).permit(:proyecto, :sae_code, :origin, :amount, :concept, :description, :date, :organism, :document, :financing, :doc_code, :doc_date, :unit, :observations)
    end

end
