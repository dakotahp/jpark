class Cage < ApplicationRecord
  # I could use a formal enum in Rails, too
  CARNIVORE = "carnivore".freeze
  HERBIVORE = "herbivore".freeze

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
    if max_capacity != dinosaurs.count && species.to_sym == dinosaur.kind
      CageDinosaur.create!(
        cage: self,
        dinosaur: dinosaur
      )
    else
      # I would normally iterate on this. Not the best pattern.
      # Failing harder with a thrown error would be more ideal but catching
      # it everywhere else adds complexity and scope in the controller
      # where logic can get messy very quickly.
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
end
