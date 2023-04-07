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

  # A dinosaur can have only one active cage.
  # This allows for future tracking of what cages a dinosaur was ever in
  # if a new attribute was added like `active`.
  has_many :cage_dinosaurs
  has_many :cages, through: :cage_dinosaurs

  validates :name, presence: true
  validates :species, inclusion: { in: ALL_SPECIES,
    message: "%{value} is not a valid species" }

  scope :carnivores, -> { where(species: CARNIVORES) }
  scope :herbivores, -> { where(species: HERBIVORES) }

  # Would be modified to add scoping to whatever cage is
  # currently active per comment for `has_many` associations.
  def active_cage
    cages.first
  end

  # Probably alternative ways to do this. I always err in favor
  # of dynamic functionality until added parameter complexity is needed.
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
