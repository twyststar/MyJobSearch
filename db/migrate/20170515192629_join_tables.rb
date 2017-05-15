class JoinTables < ActiveRecord::Migration[5.1]
  def change
    create_table(:interviews_openings) do |t|
      t.column(:interview_id, :integer)
      t.column(:opening_id, :integer)
    end

    create_table(:calendars_interviews) do |t|
      t.column(:calendar_id, :integer)
      t.column(:interview_id, :integer)
    end

    create_table(:calendars_openings) do |t|
      t.column(:calendar_id, :integer)
      t.column(:opening_id, :integer)
    end

    create_table(:calendars_organizations) do |t|
      t.column(:calendar_id, :integer)
      t.column(:organization_id, :integer)
    end

    create_table(:contacts_organizations) do |t|
      t.column(:contact_id, :integer)
      t.column(:organization_id, :integer)
    end

    create_table(:organizations_tags) do |t|
      t.column(:organization_id, :integer)
      t.column(:tag_id, :integer)
    end
    create_table(:openings_tags) do |t|
      t.column(:opening_id, :integer)
      t.column(:tag_id, :integer)
    end
    create_table(:contacts_tags) do |t|
      t.column(:contact_id, :integer)
      t.column(:tag_id, :integer)
    end

    create_table(:contacts_openings) do |t|
      t.column(:contact_id, :integer)
      t.column(:opening_id, :integer)
    end
  end
end
