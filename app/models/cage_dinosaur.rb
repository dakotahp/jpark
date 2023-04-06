class CageDinosaur < ApplicationRecord
  belongs_to :dinosaur
  belongs_to :cage
end
