class Interview < ActiveRecord::Base
  belongs_to(:openings)
  belongs_to(:calendar)
  has_and_belongs_to_many(:notes)
end
