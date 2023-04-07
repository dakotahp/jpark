require "rails_helper"

RSpec.describe "Dinosaurs", type: :request do
  describe "GET /dinosaurs.json" do
    it "returns dinosaurs found" do
      dino = Dinosaur.create!(name: "Rex", species: "Tyrannosaurus")

      get "/dinosaurs.json"

      json_response = JSON.parse(response.body)
      dino_response = json_response.dig("data")[0]
      expect(dino_response.dig("id")).to eq(dino.id)
      expect(dino_response.dig("name")).to eq(dino.name)
      expect(dino_response.dig("species")).to eq(dino.species)
      expect(response.status).to eq(200)
    end
  end

  describe "GET /dinosaurs/1.json" do
    it "returns dinosaur found" do
      dino = Dinosaur.create!(name: "Rex", species: "Tyrannosaurus")

      get "/dinosaurs/1.json"

      json_response = JSON.parse(response.body)
      dino_response = json_response.dig("data")
      expect(dino_response.dig("id")).to eq(dino.id)
      expect(dino_response.dig("name")).to eq(dino.name)
      expect(dino_response.dig("species")).to eq(dino.species)
      expect(response.status).to eq(200)
    end

    it "returns dinosaur's active cage" do
      dino = Dinosaur.create!(
        name: "Rex",
        species: "Tyrannosaurus"
      )
      cage = Cage.create!(
        name: "Carnivores",
        species: Cage::CARNIVORE
      )
      cage.add_dinosaur!(dino)

      get "/dinosaurs/1.json"

      json_response = JSON.parse(response.body)
      dino_response = json_response.dig("data").dig("active_cage")
      expect(dino_response.dig("id")).to eq(cage.id)
      expect(dino_response.dig("name")).to eq(cage.name)
      expect(response.status).to eq(200)
    end

    it "shows error message if dinosaur not found" do
      Dinosaur.create!(name: "Rex", species: "Tyrannosaurus")

      get "/dinosaurs/100.json"

      json_response = JSON.parse(response.body)
      error_response = json_response.dig("errors")
      expect(error_response).to be_present
      expect(response.status).to eq(404)
    end
  end

  describe "CREATE /dinosaurs.json" do
    it "returns dinosaur created when valid" do
      post "/dinosaurs.json", params: {
        dinosaur: {
          name: "Rex",
          species: "Tyrannosaurus"
        }
      }

      expect(response.status).to eq(200)
    end

    it "returns error message when params invalid" do
      post "/dinosaurs.json", params: {
        dinosaur: {
          name: "Rex"
        }
      }

      json_response = JSON.parse(response.body)
      error_response = json_response.dig("errors")
      expect(error_response).to be_present
    end
  end
end
