class CreateLoginTable < ActiveRecord::Migration[5.1]
  def change
    create_table(:logins) do |t|
      t.column(:user_name, :string)
      t.column(:password, :string)
    end
  end
end
