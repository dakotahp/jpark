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

  def show
    @dino = Dinosaur.find_by(id: params[:id])
    @errors = nil

    respond_to do |format|
      if @dino.present?
        format.json
      else
        @errors = "dinosaur not found"
        format.json { render status: :not_found }
      end
    end
  end

  def index
    # Better ways to do this, for sure. But, I was hoping to make it
    # smart and avoid users having to specify species name "Tyrannosaurus"
    # AND classification.
    if params[:species].present? && species_params[:species] == "carnivore"
      @dinos = Dinosaur.carnivores
    elsif params[:species].present? && species_params[:species] == "herbivore"
      @dinos = Dinosaur.herbivores
    else
      @dinos = Dinosaur.all
    end

    respond_to do |format|
      format.json
    end
  end

  private

  def dinosaur_params
    params.require(:dinosaur).permit(:name, :species)
  end

  def species_params
    params.permit(:species)
  end
end
