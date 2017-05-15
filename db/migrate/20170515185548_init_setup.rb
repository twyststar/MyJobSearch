class InitSetup < ActiveRecord::Migration[5.1]
  def change
    create_table(:openings) do |t|
      t.column(:name, :string)
      t.column(:salary, :string)
      t.column(:desc, :string)
      t.column(:link, :string)
      t.column(:organization_id, :integer)
      t.column(:notes, :string)
      t.column(:cover_letter, :string)
      t.column(:location, :string)
    end

    create_table(:interviews) do |t|
      t.column(:notes, :string)
      t.column(:location, :string)
    end

    create_table(:calendars) do |t|
      t.column(:date, :date)
      t.column(:notes, :string)
    end

    create_table(:categories) do |t|
      t.column(:name, :string)
    end

    create_table(:organizations) do |t|
      t.column(:name, :string)
      t.column(:desc, :string)
      t.column(:headquarters, :string)
      t.column(:link, :string)
    end

    create_table(:contacts) do |t|
      t.column(:name, :string)
      t.column(:title, :string)
      t.column(:address, :string)
      t.column(:phone, :string)
      t.column(:email, :string)
      t.column(:linkedin, :string)
      t.column(:context, :string)
      t.column(:notes, :string)
    end
  end
end
