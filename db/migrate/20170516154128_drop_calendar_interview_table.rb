class DropCalendarInterviewTable < ActiveRecord::Migration[5.1]
  def change
    drop_table(:calendars_interviews)
  end
end
