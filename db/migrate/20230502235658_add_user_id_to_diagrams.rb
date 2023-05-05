class AddUserIdToDiagrams < ActiveRecord::Migration[6.1]
  def change
    add_column :diagrams, :user_id, :integer

  end
end
