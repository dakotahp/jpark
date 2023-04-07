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

  ALL_SPECIES = CARNIVORES + HERBIVORES

  validates :name, presence: true
  validates :species, inclusion: { in: ALL_SPECIES,
    message: "%{value} is not a valid species" }

  scope :carnivores, -> { where(species: CARNIVORES) }
  scope :herbivores, -> { where(species: HERBIVORES) }

  def carnivore?
    CARNIVORES.include?(species)
  end

  def herbivore?
    HERBIVORES.include?(species)
  end
end
