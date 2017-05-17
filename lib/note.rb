class Note < ActiveRecord::Base
  has_and_belongs_to_many(:openings)
  has_and_belongs_to_many(:interviews)
end
