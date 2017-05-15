class DropCategoriesTableAndCreateTagsTable < ActiveRecord::Migration[5.1]
  def change
    drop_table(:categories)
    create_table(:tags) do |t|
      t.column(:name, :string)
    end
  end
end
