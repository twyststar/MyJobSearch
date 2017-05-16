class Opening < ActiveRecord::Base
  belongs_to(:organization)
  has_and_belongs_to_many(:tags)
  has_and_belongs_to_many(:contacts)
  has_and_belongs_to_many(:calendars)
  has_many(:interviews)
end
