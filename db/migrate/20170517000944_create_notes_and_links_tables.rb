class CreateNotesAndLinksTables < ActiveRecord::Migration[5.1]
  def change
    create_table(:notes) do |t|
      t.column(:notes, :string)
    end
    create_table(:my_links) do |t|
      t.column(:text, :string)
      t.column(:url, :string)
    end

    create_table(:interviews_notes) do |t|
      t.column(:calendar_id, :integer)
      t.column(:interview_id, :integer)
    end
    create_table(:calendars_notes) do |t|
      t.column(:calendar_id, :integer)
      t.column(:interview_id, :integer)
    end
    create_table(:contacts_notes) do |t|
      t.column(:calendar_id, :integer)
      t.column(:interview_id, :integer)
    end
    create_table(:notes_organizations) do |t|
      t.column(:calendar_id, :integer)
      t.column(:interview_id, :integer)
    end
    create_table(:notes_openings) do |t|
      t.column(:calendar_id, :integer)
      t.column(:interview_id, :integer)
    end

  end
end
