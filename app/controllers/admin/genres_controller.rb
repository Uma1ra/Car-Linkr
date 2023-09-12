class Admin::GenresController < ApplicationController

  def index
    @genres = Genre.all
    @new_genre = Genre.new
    @genre = Genre.first
    @subgenre = Subgenre.new
  end

  def create
    @genres = Genre.all
    @new_genre = Genre.new(genre_params)
    @new_genre.save ?
    (redirect_to request.referer, notice: "ジャンルが登録されました")
    : (render :index, alert: "ジャンル登録に失敗しました")
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    @genre.update(genre_params) ?
    (redirect_to admin_genres_path, notice: "ジャンルを編集しました")
    : (render :edit, alert: "ジャンルの編集に失敗しました")
  end

  private

  def genre_params
    params.require(:genre).permit(:name, subgenres_attributes: [:name])
  end

end
