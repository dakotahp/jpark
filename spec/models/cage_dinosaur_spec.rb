require "rails_helper"

RSpec.describe CageDinosaur, type: :model do
  context "associations" do
    it { should belong_to(:dinosaur) }
    it { should belong_to(:cage) }
  end
end
