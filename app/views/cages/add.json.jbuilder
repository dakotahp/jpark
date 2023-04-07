json.data do
  json.cage @cage
  json.dinosaurs @cage&.dinosaurs
end

json.errors @cage.errors
