class EditInterviewTable < ActiveRecord::Migration[5.1]
  def change
    remove_column(:interviews, :notes)
    add_column(:interviews, :opening_id, :integer)
  end
end
