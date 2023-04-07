json.data do
  json.array! @cages do |cage|
    json.id cage.id
    json.name cage.name
    json.dinosaurs cage&.dinosaurs
    json.dinosaur_count cage.num_dinosaurs
    json.created_at cage.created_at
  end
end

json.errors ""
