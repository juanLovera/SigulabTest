class Execution < ActiveRecord::Base
  belongs_to :commitment
  has_one :check
end
