json.data do
  json.array! @dinos do |dino|
    json.id dino.id
    json.name dino.name
    json.species dino.species
    json.created_at dino.created_at
  end
end

json.dino_count @dinos.count

json.errors ""
