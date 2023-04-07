require 'rails_helper'

RSpec.describe "Cages", type: :request do
  describe "GET /cages.json" do
    it "returns all cages when no species specified" do
      cage1 = Cage.create!(
        name: "Carnivores",
        species: Cage::CARNIVORE
      )
      cage2 = Cage.create!(
        name: "Herbivores",
        species: Cage::HERBIVORE
      )

      get '/cages.json'

      json_response = JSON.parse(response.body)
      cages_response = json_response.dig("data")

      expect(response.status).to eq(200)
      expect(cages_response[0].dig("id")).to eq(cage1.id)
      expect(cages_response[1].dig("id")).to eq(cage2.id)
    end

    it "returns filtered list of cages when species specified" do
      cage = Cage.create!(
        name: "Carnivores",
        species: Cage::CARNIVORE
      )
      Cage.create!(
        name: "Herbivores",
        species: Cage::HERBIVORE
      )

      get '/cages.json?species=carnivore'

      json_response = JSON.parse(response.body)
      cages_response = json_response.dig("data")

      expect(response.status).to eq(200)
      expect(cages_response[0].dig("id")).to eq(cage.id)
      expect(cages_response.count).to eq(1)
    end
  end

  describe "CREATE /cages.json" do
    it "returns cage created when valid" do
      post '/cages.json', params: {
        cage: {
          name: "Carnivores",
          species: Cage::CARNIVORE
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

  describe "GET /cage/1.json" do
    it "returns cage" do
      cage = Cage.create!(
        name: "Carnivores",
        species: Cage::CARNIVORE
      )
      dino = Dinosaur.create!(name: "Rex", species: "Tyrannosaurus")
      cage.add_dinosaur!(dino)

      get '/cages/1.json'

      json_response = JSON.parse(response.body)
      cage_response = json_response.dig("data").dig("cage")
      dinosaur_response = json_response.dig("data").dig("dinosaurs").first

      expect(response.status).to eq(200)
      expect(cage_response.dig("id")).to eq(cage.id)
      expect(dinosaur_response.dig("id")).to eq(dino.id)
    end

    it "returns error message when cage not found" do
      get '/cages/100.json'

      json_response = JSON.parse(response.body)
      expect(response.status).to eq(404)
      expect(json_response.dig("errors")).to be_present
    end
  end

  describe "POST /cages/add.json" do
    it "adds a dinosaur to a cage" do
      cage = Cage.create!(
        name: "Carnivores",
        species: Cage::CARNIVORE
      )
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
      cage = Cage.create!(
        name: "Carnivores",
        species: Cage::CARNIVORE
      )
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
      expect(response.status).to eq(422)
      expect(json_response.dig("errors")).to be_present
    end
  end

  describe "DELETE /cages/remove.json" do
    it "removes a dinosaur from a cage" do
      cage = Cage.create!(
        name: "Carnivores",
        species: Cage::CARNIVORE
      )
      dino = Dinosaur.create!(name: "Rex", species: "Tyrannosaurus")
      cage.add_dinosaur!(dino)

      delete '/cages/remove.json', params: {
        cage: {
          cage_id: cage.id,
          dinosaur_id: dino.id
        }
      }

      # json_response = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(cage.dinosaurs.reload.count).to eq(0)
    end
  end
end
