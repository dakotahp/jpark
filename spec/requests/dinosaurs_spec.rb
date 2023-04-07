require 'rails_helper'

RSpec.describe "Dinosaurs", type: :request do
  describe "GET /dinosoaurs.json" do
    it "returns dinosoaurs found" do
      Dinosaur.create!(name: "Rex", species: "Tyrannosaurus")

      get "/dinosaurs.json"

      byebug
      expect(response.body).to eq('{"status":"online"}')
      expect(response.status).to eq(200)
    end
  end

  describe "CREATE /dinosoaurs.json" do
    it "returns dinosaur created when valid"

    it "returns error message when params invalid"
  end
end
