class FixNoteJoinTables < ActiveRecord::Migration[5.1]
  def change
    remove_column(:calendars_notes, :interview_id)
    remove_column(:contacts_notes, :calendar_id)
    remove_column(:contacts_notes, :interview_id)
    remove_column(:interviews_notes, :calendar_id)
    remove_column(:notes_openings, :calendar_id)
    remove_column(:notes_openings, :interview_id)
    remove_column(:notes_organizations, :interview_id)
    remove_column(:notes_organizations, :calendar_id)
  
  end
end
