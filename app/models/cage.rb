class Cage < ApplicationRecord
  has_many :cage_dinosaurs
  has_many :dinosaurs, through: :cage_dinosaurs

  validates :name, presence: true

  def add_dinosaur!(dinosaur)
    if kind == dinosaur.kind
      CageDinosaur.create!(
        cage: self,
        dinosaur: dinosaur
      )
    else
      false
    end
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
