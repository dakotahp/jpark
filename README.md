# README

My approach was to use jbuilder since it is built into rails and a quick way to
bootstrap an API. While I haven't used it much for formal APIs, it is very easy
to use when compared to standard rails controller functionality so I went with that.
The JBuilder template functionality works good but over-all I would use something
more formal and robust in the real world.

I did TDD for all of this so the specs will describe pretty much everything it does.

Other thoughts:
* There are more complex ways to structure the difference in dinosaur types like single-table inheritance or subclasses. In the interest of time, I am keeping it more on the simple side as those other approaches have constraints that I didn't want to battle at this time.
* I would DRY up the specs A LOT more. In the interest of time I left that for a "future refactor" as well as for readability on your part.
* I didn't bother with spec factories, either. For simpicity and speed. Again, that would really help with DRYing things up and would be what I would normally do.
* Ideally all other edge cases in the APIs would be handled like any relevant records not being found. The limitations of rails controllers would push me to use something third party API library that would assist with that. Rails controller response code functionality gets messy, in my experience.
* The URLs and routing would ideally be a little more RESTful: DELETE /cages/1/dinosaur/1 etc. Nesting resources adds a bit more scope and I didn't want to hack the URLs at the routing layer to fake it.

## Features

* Query cages (with species filter)
* Query one cage (showing dinosaurs)
* Add dinosaur from a cage
* Remove dinosaur from a cage
* Query all dinosaurs
* Query a dinosaur (shows active cage)
* Repo is somewhat linted with `rubocop`. Fixed some glaring things but didn't go as far as fight a style guide.
* I didn't go so far as to add power status because I have a few refactors in mind if I did that: adding a small state machine to Cage to help validate status changes and possibly moving management of cages into a third-party class to manage rather than the Cage model itself. That would allow to cage model to have to be a little less concerned over things that could be considered beyond the simple resource.

## Usage

An easy way to try out the API is to use the terminal. It looks better if you install `jq` with `brew install jq`.

```
rails db:migrate db:seed
rails s
```

That will seed some data for the following examples. This will return all dinosaurs, species filtered dinosaurs, a specific dinosaur, and a not found response, respectively:

```
curl http://localhost:3000/dinosaurs.json | jq

curl http://localhost:3000/dinosaurs.json?species\=carnivore | jq
curl http://localhost:3000/dinosaurs.json?species\=herbivore | jq

curl http://localhost:3000/dinosaurs/1.json | jq

curl http://localhost:3000/dinosaurs/100.json | jq
```

See the contents of all cages, a specific species, or a specific cage, respectively:

```
curl http://localhost:3000/cages.json | jq

curl http://localhost:3000/cages.json\?species\=carnivore | jq
curl http://localhost:3000/cages.json\?species\=herbivore | jq

curl http://localhost:3000/cages/1.json | jq
```

Add a dinosaur to a cage with:

```
curl -H "Content-Type: application/json" --request POST --data '{"cage": {"cage_id": 1, "dinosaur_id": 3}}' http://localhost:3000/cages/add.json | jq
```

Create a new cage, add a dinosaur to it, and then query it:

```
curl -H "Content-Type: application/json" --request POST --data '{"cage": {"name": "Other Herbivores", "species": "herbivore"}}' http://localhost:3000/cages.json | jq

curl -H "Content-Type: application/json" --request POST --data '{"cage": {"cage_id": 3, "dinosaur_id": 7}}' http://localhost:3000/cages/add.json | jq

curl http://localhost:3000/cages/3.json | jq
```

Finally, you can remove the dinosaur from the cage and check it again:

```
curl -H "Content-Type: application/json" --request DELETE --data '{"cage": {"cage_id": 3, "dinosaur_id": 7}}' http://localhost:3000/cages/remove.json | jq

curl http://localhost:3000/cages/3.json | jq
```

All specs should be passing for verification with `rspec`.

## Assignment

### The Problem

It's 1993 and you're the lead software developer for the new Jurassic Park! Park operations needs a system to keep track of the different cages around the park and the different dinosaurs in each one. You'll need to develop a JSON formatted RESTful API to allow the builders to create new cages. It will also allow doctors and scientists the ability to edit/retrieve the statuses of dinosaurs and cages.

### Business Requirements

Please attempt to implement the following business requirements:

* All requests should respond with the correct HTTP status codes and a response, if necessary, representing either the success or error conditions.
* Data should be persisted using some flavor of SQL.
* Each dinosaur must have a name.
* Each dinosaur is considered an herbivore or a carnivore, depending on its species.
* Carnivores can only be in a cage with other dinosaurs of the same species.
* Each dinosaur must have a species (See enumerated list below, feel free to add others).
* Herbivores cannot be in the same cage as carnivores.
* Use Carnivore dinosaurs like Tyrannosaurus, Velociraptor, Spinosaurus and Megalosaurus.
* Use Herbivores like Brachiosaurus, Stegosaurus, Ankylosaurus and Triceratops.

### Technical Requirements

The following technical requirements must be met:

* ~~This project should be done in Ruby on Rails 6 or newer.~~
* ~~This should be done using version control, preferably git.~~
* ~~The project should include a README that addresses anything you may not have completed. It should also address what additional changes you might need to make if the application were intended to run in a concurrent environment. Any other comments or thoughts about the project are also welcome.~~

### Bonus Points

* ~~Cages have a maximum capacity for how many dinosaurs it can hold.~~
* ~~Cages know how many dinosaurs are contained.~~
* Cages have a power status of ACTIVE or DOWN.
* Cages cannot be powered off if they contain dinosaurs.
* Dinosaurs cannot be moved into a cage that is powered down.
* ~~Must be able to query a listing of dinosaurs in a specific cage.~~
* When querying dinosaurs or cages they should be filterable on their attributes (Cages on their power status and ~~dinosaurs on species~~).
* ~~Automated tests that ensure the business logic implemented is correct.~~
