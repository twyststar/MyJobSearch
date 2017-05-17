class AddTextCol < ActiveRecord::Migration[5.1]
  def change
    add_column(:notes, :text, :string)
  end
end
