require 'rails_helper'

RSpec.describe "Cages", type: :request do
  describe "CREATE /cages.json" do
    it "returns cage created when valid" do
      post '/cages.json', params: {
        cage: {
          name: "Carnivores"
        }
      }

      expect(response.status).to eq(200)
    end

    it "returns error message when params invalid" do
      post '/cages.json', params: {
        cage: {
          name: nil
        }
      }

      json_response = JSON.parse(response.body)
      error_response = json_response.dig("errors")
      expect(error_response).to be_present
      expect(response.status).to eq(422)
    end
  end

  describe "POST /cages/add.json" do
    it "adds a dinosaur to a cage" do
      cage = Cage.create!(name: "Carnivores")
      dino = Dinosaur.create!(name: "Rex", species: "Tyrannosaurus")

      post '/cages/add.json', params: {
        cage: {
          cage_id: cage.id,
          dinosaur_id: dino.id
        }
      }

      json_response = JSON.parse(response.body)
      expect(response.status).to eq(200)
    end

    it "fails to add a dinosaur of a different species to an existing cage" do
      cage = Cage.create!(name: "Carnivores")
      dino1 = Dinosaur.create!(name: "Rex", species: "Tyrannosaurus")
      # add it already rather than test the request twice
      cage.add_dinosaur!(dino1)

      # the one that shouldn't be possible to add
      dino2 = Dinosaur.create!(name: "Brach", species: "Brachiosaurus")

      post '/cages/add.json', params: {
        cage: {
          cage_id: cage.id,
          dinosaur_id: dino2.id
        }
      }

      json_response = JSON.parse(response.body)
      expect(response.status).to eq(400)
    end
  end
end
