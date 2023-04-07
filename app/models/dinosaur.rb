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

  def active_cage
    cages.first
  end

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
