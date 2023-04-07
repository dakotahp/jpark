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

  # Obviously, a dinosaur can ideally have only one cage.
  # Using the join table method made sense to me at the moment
  # and it could be validated to only allow one.
  has_many :cage_dinosaurs
  has_many :cages, through: :cage_dinosaurs

  validates :name, presence: true
  validates :species, inclusion: { in: ALL_SPECIES,
    message: "%{value} is not a valid species" }

  scope :carnivores, -> { where(species: CARNIVORES) }
  scope :herbivores, -> { where(species: HERBIVORES) }

  # Same thoughts as the similar method in Cage.
  def kind
    if carnivore?
      :carnivore
    else
      :herbivore
    end
  end

  def carnivore?
    CARNIVORES.include?(species)
  end

  def herbivore?
    HERBIVORES.include?(species)
  end
end
