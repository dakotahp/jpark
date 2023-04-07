require "rails_helper"

RSpec.describe Dinosaur, :type => :model do
  context "associations" do
    it { should have_many(:cage_dinosaurs) }
    it { should have_many(:cages) }
    it { should validate_presence_of(:name) }
  end

  it "is valid with valid attributes" do
    dino = Dinosaur.new(
      name: "Rex",
      species: "Tyrannosaurus"
    )
    expect(dino).to be_valid
  end

  it "is not valid without a name" do
    dino = Dinosaur.new(
      name: nil,
      species: "Tyrannosaurus"
    )
    expect(dino).to be_invalid
  end

  context "species" do
    it "is not valid without a species" do
      dino = Dinosaur.new(
        name: "Rex",
        species: nil
      )
      expect(dino).to be_invalid
    end

    it "is valid with carnivore species" do
      dino = Dinosaur.new(
        name: "Rex",
        species: "Tyrannosaurus"
      )
      expect(dino).to be_valid
    end

    it "is valid with herbivore species" do
      dino = Dinosaur.new(
        name: "Rex",
        species: "Brachiosaurus"
      )
      expect(dino).to be_valid
    end
  end

  describe "#herbivore?" do
    it "returns true when species in herbivore list" do
      dino = Dinosaur.new(
        name: "Rex",
        species: "Brachiosaurus"
      )
      expect(dino.herbivore?).to be_truthy
    end

    it "returns false when species NOT in herbivore list" do
      dino = Dinosaur.new(
        name: "Rex",
        species: "Tyrannosaurus"
      )
      expect(dino.herbivore?).to be_falsey
    end
  end

  describe "#carnivore?" do
    it "returns true when species in carnivore list" do
      dino = Dinosaur.new(
        name: "Rex",
        species: "Tyrannosaurus"
      )
      expect(dino.carnivore?).to be_truthy
    end

    it "returns false when species NOT in carnivore list" do
      dino = Dinosaur.new(
        name: "Rex",
        species: "Brachiosaurus"
      )
      expect(dino.carnivore?).to be_falsey
    end
  end
end
