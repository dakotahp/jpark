class AddSpeciesToCages < ActiveRecord::Migration[7.0]
  def change
    add_column :cages, :species, :string
  end
end
