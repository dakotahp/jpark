class AddDinosaurs < ActiveRecord::Migration[7.0]
  def change
    create_table :dinosaurs do |t|
      t.string :name
      t.string :species

      t.timestamps
    end
  end
end
