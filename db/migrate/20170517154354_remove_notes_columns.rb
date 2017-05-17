class RemoveNotesColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column(:calendars, :notes)
    remove_column(:contacts, :notes)
    remove_column(:openings, :notes)
  end
end
