class Admin::GenresController < ApplicationController

  def index
    @genres = Genre.all
    @new_genre = Genre.new
    @subgenre = Subgenre.new
  end

  def create
    @genres = Genre.all
    @subgenre = Subgenre.new
    @new_genre = Genre.new(genre_params)
    if @new_genre.save
      flash.now[:notice] = "ジャンルを登録しました"
    else
      flash.now[:alert] = "登録に失敗しました"
      render :error
    end
  end

  def edit
    @genre = Genre.find(params[:id])
    @genres = Genre.all
    @subgenre = Subgenre.find(params[:subgenre_id])
  end

  def update
    @genre = Genre.find(params[:id])
    @genre.update(genre_params) ?
    (redirect_to admin_genres_path, notice: "ジャンルを編集しました")
    : (render :edit, alert: "ジャンルの編集に失敗しました")
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
