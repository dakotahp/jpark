require "rails_helper"

RSpec.describe Cage, type: :model do
  context "associations" do
    it { should have_many(:cage_dinosaurs) }
    it { should have_many(:dinosaurs) }
    it { should have_many(:dinosaurs) }
    it { should validate_presence_of(:name) }
  end

  describe "#add_dinosaur!" do
    it "should allow same species to be added" do
      cage = Cage.create!(
        name: "Carnivores",
        species: Cage::CARNIVORE
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

      expect(cage.add_dinosaur!(dino2)).to be_truthy
    end

    it "should NOT allow different species to be added" do
      cage = Cage.create!(
        name: "Carnivores",
        species: Cage::CARNIVORE
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

      expect(cage.add_dinosaur!(dino2)).to be_falsey
    end

    it "should not allow capacity to be exceeded" do
      cage = Cage.create!(
        name: "Carnivores",
        species: Cage::CARNIVORE,
        max_capacity: 1
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

      expect(cage.add_dinosaur!(dino2)).to be_falsey
    end
  end

  describe "#remove_dinosaur!" do
    it "should remove dinosaur from cage" do
      cage = Cage.create!(
        name: "Carnivores",
        species: Cage::CARNIVORE
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
      cage.add_dinosaur!(dino2)

      expect(cage.dinosaurs.reload.count).to eq(2)

      cage.remove_dinosaur!(dino2)

      expect(cage.dinosaurs.reload.count).to eq(1)
    end
  end
end
