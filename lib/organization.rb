class Organization < ActiveRecord::Base
  has_many(:openings)
  has_and_belongs_to_many(:tags)
  has_and_belongs_to_many(:contacts)
  has_and_belongs_to_many(:calendars)
end
