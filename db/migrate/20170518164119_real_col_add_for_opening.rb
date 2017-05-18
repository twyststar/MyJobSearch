class RealColAddForOpening < ActiveRecord::Migration[5.1]
  def change
    add_column(:openings, :applied, :boolean)
  end
end
