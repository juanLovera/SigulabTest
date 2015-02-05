class LoadSchema < ActiveRecord::Migration
  def change
  	create_table "acts", force: true do |t|
    t.string   "numRegistro"
    t.string   "proveedor"
    t.string   "bienServicio"
    t.string   "tesis"
    t.string   "responsable"
    t.string   "justificacion"
    t.string   "providencia"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_id"
    t.integer  "specification_id"
  end

  create_table "applications", force: true do |t|
    t.string   "fechaRequerida"
    t.string   "descripcion"
    t.string   "uso"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checks", force: true do |t|
    t.integer  "execution_id"
    t.string   "check_number"
    t.float    "amount"
    t.date     "elaboration_date"
    t.date     "sign_date"
    t.date     "delivery_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "checks", ["execution_id"], name: "index_checks_on_execution_id", using: :btree

  create_table "chemical_substances", force: true do |t|
    t.string   "name"
    t.string   "matter_states"
    t.string   "meassure"
    t.string   "cas"
    t.string   "status"
    t.string   "responsible"
    t.string   "location"
    t.date     "expiration_date"
    t.boolean  "controlled"
    t.boolean  "rI7"
    t.boolean  "rI4"
    t.boolean  "toxic"
    t.boolean  "oxidant"
    t.boolean  "explosive"
    t.boolean  "irritating"
    t.boolean  "inflamable"
    t.boolean  "corrosive"
    t.boolean  "nocive"
    t.boolean  "investigation"
    t.boolean  "teaching"
    t.boolean  "extention"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "purity"
    t.float    "quantity"
    t.decimal  "cost"
    t.string   "bill"
    t.string   "buy_order"
    t.date     "adquisition_date"
    t.boolean  "showable",         default: true
    t.string   "dependency"
    t.boolean  "solicitados"
    t.string   "id2"
  end

  create_table "commitments", force: true do |t|
    t.integer  "lab_id"
    t.string   "code"
    t.float    "amount"
    t.string   "description"
    t.string   "recipient"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sae_code"
    t.text     "observations"
    t.integer  "document",     default: 0
  end

  create_table "consumables", force: true do |t|
    t.string   "name"
    t.string   "material"
    t.string   "quantity"
    t.string   "location"
    t.string   "responsible"
    t.boolean  "investigation"
    t.boolean  "teaching"
    t.boolean  "extention"
    t.boolean  "management"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "cost"
    t.string   "bill"
    t.string   "buy_order"
    t.date     "adquisition_date"
    t.text     "description"
    t.boolean  "showable",         default: true
    t.string   "dependency"
    t.boolean  "solicitados"
    t.string   "id2"
  end

  create_table "devolutions", force: true do |t|
    t.string   "numRegistro"
    t.string   "numRequisicion"
    t.boolean  "requisicion"
    t.string   "numAutorizacion"
    t.boolean  "autorizacion"
    t.string   "numCertificacion"
    t.boolean  "certificacion"
    t.string   "numSolicitud"
    t.boolean  "solicitud"
    t.string   "numInforme"
    t.boolean  "informe"
    t.string   "numOtro"
    t.boolean  "otro"
    t.string   "otro_especifico"
    t.boolean  "disponibilidad"
    t.boolean  "idioma"
    t.boolean  "discriminado"
    t.boolean  "firma"
    t.boolean  "carencia"
    t.boolean  "nombre"
    t.boolean  "direccion"
    t.boolean  "datos"
    t.boolean  "rif"
    t.boolean  "telefonos"
    t.boolean  "persona"
    t.boolean  "otroCarencia"
    t.string   "descripcion"
    t.boolean  "contacto"
    t.boolean  "copia"
    t.boolean  "factura"
    t.boolean  "foto"
    t.string   "unidadSolicitante"
    t.string   "observaciones"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_id"
    t.integer  "specification_id"
  end

  create_table "donations", force: true do |t|
    t.string   "nombreItem"
    t.string   "marca"
    t.string   "modelo"
    t.string   "cantidad"
    t.string   "unidadMedida"
    t.string   "tipo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "equipment", force: true do |t|
    t.string   "name"
    t.string   "brand"
    t.string   "model"
    t.string   "serial"
    t.integer  "national_good"
    t.string   "status"
    t.date     "last_calibration"
    t.string   "responsible"
    t.string   "location"
    t.date     "adquisition_date"
    t.string   "buy_order"
    t.string   "bill"
    t.boolean  "investigation"
    t.boolean  "teaching"
    t.boolean  "extention"
    t.boolean  "management"
    t.string   "calibrated"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "cost"
    t.float    "length"
    t.float    "depth"
    t.float    "width"
    t.string   "measurelength"
    t.string   "measuredepth"
    t.string   "measurewidth"
    t.boolean  "showable",         default: true
    t.string   "dependency"
    t.integer  "numSolicitud"
    t.boolean  "solicitados"
    t.string   "id2"
  end

  create_table "executions", force: true do |t|
    t.integer  "commitment_id"
    t.string   "code"
    t.float    "check_amount"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "document",               default: 0
    t.string   "check_number"
    t.date     "check_elaboration_date"
    t.date     "check_sign_date"
    t.date     "check_delivery_date"
    t.integer  "check_delivery_status"
    t.boolean  "check_annulled",         default: false
    t.string   "remarks"
    t.string   "document_name"
  end

  add_index "executions", ["commitment_id"], name: "index_executions_on_commitment_id", using: :btree

  create_table "incomes", force: true do |t|
    t.integer  "lab_id"
    t.float    "amount"
    t.integer  "origin",               default: 0
    t.string   "description"
    t.date     "date"
    t.string   "organism"
    t.string   "document"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sae_code"
    t.integer  "financing",            default: 0
    t.string   "doc_code"
    t.date     "doc_date"
    t.string   "unit"
    t.string   "variation"
    t.string   "resource_description"
    t.integer  "resource",             default: 0
  end

  create_table "instruments", force: true do |t|
    t.string   "name"
    t.string   "brand"
    t.string   "model"
    t.string   "measurement_unit"
    t.float    "capacity"
    t.string   "material"
    t.string   "status"
    t.string   "location"
    t.date     "last_calibration"
    t.string   "responsible"
    t.integer  "national_good"
    t.boolean  "investigation"
    t.boolean  "teaching"
    t.boolean  "extention"
    t.boolean  "management"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "cost"
    t.string   "bill"
    t.string   "buy_order"
    t.date     "adquisition_date"
    t.boolean  "showable",         default: true
    t.string   "dependency"
    t.boolean  "solicitados"
    t.string   "id2"
  end

  create_table "invitations", force: true do |t|
    t.string   "nombre"
    t.string   "rif"
    t.string   "direccion"
    t.string   "correo"
    t.string   "telefono"
    t.string   "telefono_Adicional"
    t.string   "responsable"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_id"
    t.integer  "specification_id"
    t.integer  "quote_id"
  end

  create_table "items", force: true do |t|
    t.string   "nombre"
    t.string   "tipo"
    t.text     "descripcion"
    t.integer  "dimensiones_alto"
    t.integer  "dimensiones_ancho"
    t.integer  "dimensiones_largo"
    t.integer  "cantidad"
    t.string   "unidad_alto"
    t.string   "unidad_ancho"
    t.string   "unidad_largo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "numeroBien"
    t.string   "user_id"
    t.integer  "specification_id"
  end

  create_table "itemsquotes", force: true do |t|
    t.integer "id_item"
    t.string  "nombre_item"
    t.integer "id_oferta"
    t.integer "compra"
    t.integer "specification_id"
  end

  create_table "labs", force: true do |t|
    t.string "name"
    t.string "sae_code"
    t.string "sae_name"
  end

  create_table "loans", force: true do |t|
    t.string   "ubicacion"
    t.string   "condiciones"
    t.string   "medida"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "fechaEntrega"
    t.date     "fechaTope"
    t.string   "unidadMedida"
    t.string   "descripcion"
    t.string   "uso"
  end

  create_table "projects", force: true do |t|
    t.integer  "project_number"
    t.integer  "contract"
    t.string   "title"
    t.string   "responsible"
    t.string   "sae_code"
    t.float    "amount",         default: 0.0
    t.float    "equipments",     default: 0.0
    t.float    "services",       default: 0.0
    t.float    "infrastructure", default: 0.0
    t.float    "hhrr",           default: 0.0
    t.float    "consumables",    default: 0.0
    t.date     "incoming_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "admin",          default: 0
    t.integer  "status",         default: 0
    t.float    "furniture",      default: 0.0
    t.string   "other_desc"
    t.float    "other_amount",   default: 0.0
    t.date     "annulled_date"
    t.string   "num_cuenta"
    t.string   "observation"
    t.integer  "banco"
  end

  create_table "quotes", force: true do |t|
    t.string   "nombre"
    t.string   "attachment"
    t.string   "ataname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_id"
    t.integer  "specification_id"
  end

  create_table "recommendations", force: true do |t|
    t.text    "codigo"
    t.text    "via"
    t.integer "specification_id"
    t.integer "user_id"
  end

  create_table "recommendations_empresas", force: true do |t|
    t.integer "quote_id"
    t.integer "id_informe"
    t.integer "opcion_numero"
    t.text    "empresa"
    t.integer "calidad_pro"
    t.integer "disponibilidad_pro"
    t.integer "proveedor_unico"
    t.integer "calidad_ser"
    t.integer "garantia"
    t.integer "servicio_post"
    t.integer "cumplimiento_esp"
    t.integer "precio"
    t.integer "tiempo"
    t.integer "cumplio_req"
  end

  create_table "requisitions", force: true do |t|
    t.string   "solicitante"
    t.string   "consumidor"
    t.string   "partida"
    t.string   "autor"
    t.text     "observacion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_id"
  end

  create_table "services", force: true do |t|
    t.string   "nombre"
    t.string   "numero"
    t.string   "tipo"
    t.text     "descripcion"
    t.string   "ubicacion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_id"
    t.integer  "specification_id"
  end

  create_table "specifications", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_id"
    t.string   "nombre"
    t.string   "tipo"
    t.integer  "p1"
    t.integer  "p2"
    t.integer  "p3"
    t.integer  "p4"
    t.integer  "p5"
    t.integer  "p6"
    t.integer  "p7"
  end

  create_table "tools", force: true do |t|
    t.string   "name"
    t.string   "brand"
    t.string   "type"
    t.integer  "national_good"
    t.string   "status"
    t.string   "responsible"
    t.string   "location"
    t.string   "material"
    t.string   "bill"
    t.boolean  "investigation"
    t.boolean  "teaching"
    t.boolean  "extention"
    t.boolean  "management"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "cost"
    t.string   "buy_order"
    t.date     "adquisition_date"
    t.boolean  "showable",         default: true
    t.boolean  "from_set"
    t.string   "dependency"
    t.boolean  "solicitados"
    t.string   "id2"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.boolean  "technician"
    t.boolean  "labBoss"
    t.boolean  "director"
    t.boolean  "acquisition"
    t.boolean  "acquisition_analist"
    t.boolean  "import_analist"
    t.boolean  "import"
    t.boolean  "manage"
    t.boolean  "manage_analist"
    t.boolean  "quality_analist"
    t.boolean  "quality"
    t.boolean  "gsmp"
    t.boolean  "directorate"
    t.boolean  "labassistant"
    t.boolean  "section_boss"
    t.boolean  "proy_responsible"
    t.boolean  "external"
  end
  end
end
