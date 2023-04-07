Rails.application.routes.draw do
  resources :dinosaurs, only: [:create, :index]

  resources :cages, only: [:create, :show]
  post "/cages/add", to: "cages#add"
  delete "/cages/remove", to: "cages#remove"
end
