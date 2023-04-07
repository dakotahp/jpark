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
