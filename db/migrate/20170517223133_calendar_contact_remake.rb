class CalendarContactRemake < ActiveRecord::Migration[5.1]
  def change
    create_table(:calendars_contacts) do |t|
      t.column(:calendar_id, :integer)
      t.column(:contact_id, :integer)
    end
  end
end
