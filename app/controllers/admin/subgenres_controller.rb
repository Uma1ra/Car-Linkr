class Admin::SubgenresController < ApplicationController

  def create
    @genres = Genre.all
    @subgenre = Subgenre.new(subgenre_params)
    @subgenre.save
  end
  
  def update
    subgenre = Subgenre.find(params[:id])
    subgenre.update(subgenre_params)
    redirect_to admin_genres_path
  end

  private

  def subgenre_params
    params.require(:subgenre).permit(:name, :genre_id)
  end

end
