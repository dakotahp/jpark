class CagesController < ApplicationController
  # To allow easy CURL examples in readme
  skip_before_action :verify_authenticity_token

  def create
    @cage = Cage.new(cage_params)

    respond_to do |format|
      if @cage.save
        format.json
      else
        format.json { render status: :unprocessable_entity }
      end
    end
  end

  def show
    @cage = Cage.find_by(id: params[:id])
    @errors = nil

    respond_to do |format|
      if @cage.present?
        format.json
      else
        @errors = "cage not found"
        format.json { render status: :not_found }
      end
    end
  end

  # Adds a dinosaur by primary key
  def add
    @cage = Cage.find_by(id: cage_params[:cage_id])
    dinosaur = Dinosaur.find_by(id: cage_params[:dinosaur_id])

    respond_to do |format|
      if @cage.add_dinosaur!(dinosaur)
        format.json
      else
        format.json { render status: :unprocessable_entity }
      end
    end
  end

  # Removes a dinosaur by primary key
  def remove
    @cage = Cage.find_by(id: cage_params[:cage_id])
    dinosaur = Dinosaur.find_by(id: cage_params[:dinosaur_id])

    respond_to do |format|
      if @cage.remove_dinosaur!(dinosaur)
        format.json
      else
        format.json { render status: :unprocessable_entity }
      end
    end
  end

  # Not required but helpful for debugging and implementation
  def index
    @cages = Cage.all
    respond_to do |format|
      format.json
    end
  end

  private

  def cage_params
    params.require(:cage).permit(:cage_id, :dinosaur_id, :name, :species)
  end
end
