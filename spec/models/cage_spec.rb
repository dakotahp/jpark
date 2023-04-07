require "rails_helper"

RSpec.describe Cage, :type => :model do
  context "associations" do
    it { should have_many(:cage_dinosaurs) }
    it { should have_many(:dinosaurs) }
  end

  describe "#add_dinosaur!" do
    it "should allow same species to be added" do
      cage = Cage.create!(
        name: "Carnivores"
      )

      dino1 = Dinosaur.create!(
        name: "Rex",
        species: "Tyrannosaurus"
      )

      dino2 = Dinosaur.create!(
        name: "Velo",
        species: "Velociraptor"
      )

      cage.add_dinosaur!(dino1)

      expect {
        cage.add_dinosaur!(dino2)
      }.not_to raise_exception
    end

    it "should NOT allow different species to be added" do
      cage = Cage.create!(
        name: "Carnivores"
      )

      dino1 = Dinosaur.create!(
        name: "Rex",
        species: "Tyrannosaurus"
      )

      dino2 = Dinosaur.create!(
        name: "Brach",
        species: "Brachiosaurus"
      )

      cage.add_dinosaur!(dino1)

      expect {
        cage.add_dinosaur!(dino2)
      }.to raise_exception
    end
  end
end
