class Cage < ApplicationRecord
  # I could use a formal enum in Rails, too
  CARNIVORE = "carnivore"
  HERBIVORE = "herbivore"

  SPECIES = [
    CARNIVORE,
    HERBIVORE
  ]

  has_many :cage_dinosaurs
  has_many :dinosaurs, through: :cage_dinosaurs

  validates :name, presence: true
  validates :species, inclusion: { in: SPECIES,
    message: "%{value} is not a valid species" }

  def num_dinosaurs
    dinosaurs.count
  end

  def add_dinosaur!(dinosaur)
    # Add first dino without validation or consider first one the canonical type
    if num_dinosaurs == 0 || kind == dinosaur.kind
      CageDinosaur.create!(
        cage: self,
        dinosaur: dinosaur
      )
    else
      # I would normally iterate on this. Not the best pattern.
      self.errors.add(:base, "unable to add dinosaur")
      false
    end
  end

  def remove_dinosaur!(dinosaur)
    CageDinosaur.find_by(
        cage: self,
        dinosaur: dinosaur
    ).destroy
  end

  private

  # Kinda funky. There could be a more codified way of doing this.
  # Maybe like having to specify the cage. I kind of like the dynamic
  # aspect of it for the time being. Also not performant but simple, at least.
  def kind
    if dinosaurs.map(&:carnivore?).all?
      :carnivore
    else
      :herbivore
    end
  end
end
