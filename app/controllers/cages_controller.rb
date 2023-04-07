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

  # Not required but helpful for debugging and implementation
  def index
    @cages = Cage.all
    respond_to do |format|
      format.json
    end
  end

  private

  def cage_params
    params.require(:cage).permit(:cage_id, :dinosaur_id, :name)
  end
end
