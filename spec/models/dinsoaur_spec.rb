require "rails_helper"

RSpec.describe Dinosaur, :type => :model do
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
end
