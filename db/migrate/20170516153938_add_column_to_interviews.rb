class AddColumnToInterviews < ActiveRecord::Migration[5.1]
  def change
    add_column(:interviews, :calendar_id, :integer)
  end
end
