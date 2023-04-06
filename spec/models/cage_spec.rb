require "rails_helper"

RSpec.describe Cage, :type => :model do
  context "associations" do
    it { should have_many(:cage_dinosaurs) }
    it { should have_many(:dinosaurs) }
  end
end
