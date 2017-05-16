class Tag < ActiveRecord::Base
  has_and_belongs_to_many(:organizations)
  has_and_belongs_to_many(:contacts)
  has_and_belongs_to_many(:openings)
end
