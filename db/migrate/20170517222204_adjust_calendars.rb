class AdjustCalendars < ActiveRecord::Migration[5.1]
  def change
    add_column(:calendars, :notes, :string)
  end
end
