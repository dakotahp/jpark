json.data do
  json.cage @cage
  json.dinosaurs @cage&.dinosaurs
  json.dinosaur_count @cage.num_dinosaurs
end

json.errors @errors
