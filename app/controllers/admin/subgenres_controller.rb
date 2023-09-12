class Admin::SubgenresController < ApplicationController

  def create
    # genre = Genre.find(params[:genre_id])
    subgenre = Subgenre.new(subgenre_params)
    subgenre.save
    redirect_to admin_genres_path
  end

  private

  def subgenre_params
    params.require(:subgenre).permit(:name, :genre_id)
  end

end
