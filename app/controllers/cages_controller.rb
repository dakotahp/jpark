class CagesController < ApplicationController
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


  # Adds a dinosaur by primary key
  def add
    @status = :created
    cage = Cage.find_by(id: cage_params[:cage_id])
    dinosaur = Dinosaur.find_by(id: cage_params[:dinosaur_id])
    @error = nil

    if !cage.present? && !dinosaur.present?
      @error = "resources not found"
    end

    @cage_dinosaur = cage.add_dinosaur!(dinosaur)

    respond_to do |format|
      format.json
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
    params.require(:cage).permit(:name)
  end
end
