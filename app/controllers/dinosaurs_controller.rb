class DinosaursController < ApplicationController
  def create
    @dino = Dinosaur.new(dinosaur_params)
    if @dino.valid?
      @dino.save
    end

    respond_to do |format|
      format.json
    end
  end

  # Not required but helpful for debugging and implementation
  def index
    @dinos = Dinosaur.all
    respond_to do |format|
      format.json
    end
  end

  private

  def dinosaur_params
    params.require(:dinosaur).permit(:name, :species)
  end
end
