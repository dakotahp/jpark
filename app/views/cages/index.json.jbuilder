json.data do
  json.array! @cages do |cage|
    json.id cage.id
    json.name cage.name
    json.species cage.species
    json.dinosaurs cage&.dinosaurs
    json.dinosaur_count cage.num_dinosaurs
    json.created_at cage.created_at
  end
end

json.cage_count @cages.count

json.errors ""
