class ChangeCalendarAssociations < ActiveRecord::Migration[5.1]
  def change
    drop_table(:calendars_notes)
  end
end
