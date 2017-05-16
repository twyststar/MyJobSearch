class Interview < ActiveRecord::Base
  belongs_to(:openings)
  belongs_to(:calendar)
end
