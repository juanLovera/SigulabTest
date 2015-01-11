# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141121161335) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.string   "specification_id"
  end

  create_table "checks", force: true do |t|
    t.integer  "execution_id"
    t.string   "check_number"
    t.float    "amount"
    t.datetime "elaboration_date"
    t.datetime "sign_date"
    t.datetime "delivery_date"
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
  end

  create_table "commitments", force: true do |t|
    t.integer  "lab_id"
    t.string   "code"
    t.float    "amount"
    t.string   "description"
    t.string   "recipient"
    t.datetime "date"
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
    t.boolean  "contacto"
    t.boolean  "copia"
    t.boolean  "factura"
    t.boolean  "foto"
    t.text     "observaciones"
    t.string   "unidadSolicitante"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_id"
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
    t.datetime "check_elaboration_date"
    t.datetime "check_sign_date"
    t.datetime "check_delivery_date"
    t.integer  "check_delivery_status"
  end

  add_index "executions", ["commitment_id"], name: "index_executions_on_commitment_id", using: :btree

  create_table "incomes", force: true do |t|
    t.integer  "lab_id"
    t.float    "amount"
    t.integer  "origin",      default: 0
    t.string   "description"
    t.datetime "date"
    t.string   "organism"
    t.string   "document"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sae_code"
    t.integer  "financing",   default: 0
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
  end

  create_table "invitations", force: true do |t|
    t.string   "nombreEmpresa"
    t.string   "direccion"
    t.string   "correo"
    t.string   "telefono"
    t.string   "telefonoAdicional"
    t.string   "responsable"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_id"
  end

  create_table "items", force: true do |t|
    t.string   "nombre"
    t.string   "tipo"
    t.text     "descripcion"
    t.string   "dimensiones"
    t.integer  "cantidad"
    t.string   "unidad"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "numeroBien"
    t.string   "user_id"
  end

  create_table "labs", force: true do |t|
    t.string "name"
    t.string "sae_code"
    t.string "sae_name"
  end

  create_table "quotes", force: true do |t|
    t.string   "nombre"
    t.string   "attachment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_id"
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
    t.string   "numeroBien"
    t.string   "tipo"
    t.text     "descripcion"
    t.string   "ubicacion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_id"
  end

  create_table "specifications", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_id"
    t.string   "nombre"
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

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
