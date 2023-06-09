Rails.application.routes.draw do
  resources :dinosaurs, only: [:create, :show, :index]

  resources :cages, only: [:create, :show, :index]
  post "/cages/add", to: "cages#add"
  delete "/cages/remove", to: "cages#remove"
end
