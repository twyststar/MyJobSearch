class CorrectNotesTableAttribute < ActiveRecord::Migration[5.1]
  def change
    remove_column(:notes, :notes)
    
  end
end
