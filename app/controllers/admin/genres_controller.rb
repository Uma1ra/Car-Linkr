class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

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
      @genres = Genre.all
      @genre = Genre.find(params[:id])
      @subgenre = Subgenre.find(params[:subgenre_id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice: "ジャンルを更新しました"
    else
      flash[:alert] = "更新に失敗しました"
      render :edit
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
