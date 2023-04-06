class Cage < ApplicationRecord
  has_many :cage_dinosaurs
  has_many :dinosaurs, through: :cage_dinosaurs
end
