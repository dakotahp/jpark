class AddCageDinosaurs < ActiveRecord::Migration[7.0]
  def change
    create_table :cage_dinosaurs do |t|
      # Can use more formal rails foreign key methods but this is simple
      t.integer :cage_id
      t.integer :dinosaur_id

      t.timestamps
    end
  end
end
