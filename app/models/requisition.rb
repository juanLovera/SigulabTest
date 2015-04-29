class Requisition < ActiveRecord::Base
    mount_uploader :attachment, AttachmentUploader
	validates_presence_of :solicitante
	validates_presence_of :autor
	belongs_to :user
end
