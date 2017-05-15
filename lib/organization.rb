class Organization < ActiveRecord::Base
  has_many(:openings)
  has_and_belongs_to_many(:tags)
end
