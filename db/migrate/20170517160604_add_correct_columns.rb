class AddCorrectColumns < ActiveRecord::Migration[5.1]
  def change
    add_column(:contacts_notes, :contact_id, :integer)
    add_column(:contacts_notes, :note_id, :integer)
    add_column(:calendars_notes, :note_id, :integer)
    add_column(:interviews_notes, :note_id, :integer)
    add_column(:notes_openings, :note_id, :integer)
    add_column(:notes_openings, :opening_id, :integer)
    add_column(:notes_organizations, :note_id, :integer)
    add_column(:notes_organizations, :organization_id, :integer)
  end
end
