class CreateDiagrams < ActiveRecord::Migration[6.1]
  def change
    create_table :diagrams do |t|
      t.string :name
      t.string :type
      t.text :description
      t.text :source_code

      t.timestamps
    end
  end
end
