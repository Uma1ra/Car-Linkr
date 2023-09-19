class Admin::SubgenresController < ApplicationController

  def create
    @genres = Genre.all
    @subgenre = Subgenre.new(subgenre_params)
    if @subgenre.save
      flash.now[:notice] = "サブジャンルを登録しました"
    else
      flash.now[:alert] = "登録に失敗しました"
      render :error
    end
  end
  
  def update
    @subgenre = Subgenre.find(params[:id])
    if @subgenre.update(subgenre_params)
      redirect_to admin_genres_path, notice: "サブジャンルを更新しました"
    else
      render :edit, alert: "更新に失敗しました"
    end
  end

  private

  def subgenre_params
    params.require(:subgenre).permit(:name, :genre_id)
  end

end
