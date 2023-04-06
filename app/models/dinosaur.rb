class Dinosaur < ApplicationRecord
  CARNIVORES = [
    "Tyrannosaurus",
    "Velociraptor",
    "Spinosaurus",
    "Megalosaurus"
  ]

  HERBIVORES = [
    "Brachiosaurus",
    "Stegosaurus",
    "Ankylosaurus",
    "Triceratops"
  ]

  validates :name, presence: true
  validates :species, inclusion: { in: (CARNIVORES+HERBIVORES),
    message: "%{value} is not a valid species" }
end
