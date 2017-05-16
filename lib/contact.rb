class Contact < ActiveRecord::Base
  has_and_belongs_to_many(:organizations)
  has_and_belongs_to_many(:tags)
  has_and_belongs_to_many(:openings)
end
