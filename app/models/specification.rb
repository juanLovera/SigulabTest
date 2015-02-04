class Specification < ActiveRecord::Base
	belongs_to :user
	has_many :acts
end
