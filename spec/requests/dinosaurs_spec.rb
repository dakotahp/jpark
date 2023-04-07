require 'rails_helper'

RSpec.describe "Dinosaurs", type: :request do
  describe "GET /dinosoaurs.json" do
    it "returns dinosoaurs found" do
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

  describe "CREATE /dinosoaurs.json" do
    it "returns dinosaur created when valid" do
      post '/dinosaurs.json', params: {
        dinosaur: {
          name: "Rex",
          species: "Tyrannosaurus"
        }
      }

      expect(response.status).to eq(200)
    end

    it "returns error message when params invalid" do
      post '/dinosaurs.json', params: {
        dinosaur: {
          name: "Rex"
        }
      }

      json_response = JSON.parse(response.body)
      error_response = json_response.dig("errors")
      expect(error_response).to be_present
      expect(response.status).to eq(403)
    end
  end
end
