json.data do
  json.id @dino&.id
  json.name @dino&.name
  json.species @dino&.species
  json.active_cage @dino&.active_cage
  json.created_at @dino&.created_at
  json.updated_at @dino&.updated_at
end

json.errors @errors
