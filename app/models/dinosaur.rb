class Dinosaur < ApplicationRecord
  CARNIVORES = [
    "Tyrannosaurus"
    "Velociraptor",
    "Spinosaurus",
    "Megalosaurus"
  ]

  HERBIVORES = [
    "Brachiosaurus"
    "Stegosaurus"
    "Ankylosaurus",
    "Triceratops"
  ]

  validates :name, presence: true
end
