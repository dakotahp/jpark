# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Seed every kind of dinosaur
Dinosaur.destroy_all
Dinosaur::ALL_SPECIES.each_with_index do |species, index|
  Dinosaur.create!(
    name: "Dino #{index}",
    species: species
  )
end

# Create a cage with some carnivores
Cage.destroy_all
cage = Cage.create!(
  name: "Carnivores",
  species: Cage::CARNIVORE
)

# Add some carnivores to it
CageDinosaur.destroy_all
cage.add_dinosaur!(Dinosaur.carnivores.first)
cage.add_dinosaur!(Dinosaur.carnivores.last)

p "All done!"
