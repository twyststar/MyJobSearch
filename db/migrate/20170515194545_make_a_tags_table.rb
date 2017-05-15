class MakeATagsTable < ActiveRecord::Migration[5.1]
  def change
    create_table(:tags) do |t|
      t.column(:name, :string)
    end
  end
end
