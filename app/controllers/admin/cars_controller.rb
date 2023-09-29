class Admin::CarsController < ApplicationController
  before_action :authenticate_admin!
  before_action :find_car_id, only: [:show, :edit, :update, :destroy]

  def index
    if params[:subgenre_id]
      subgenre = Subgenre.find(params[:subgenre_id])
      @cars = subgenre.cars.page(params[:page]).per(10)
    else
      @cars = Car.page(params[:page]).per(10)
    end
  end

  def new
    @car = Car.new
  # サブジャンルの方から必要なジャンルのみ
    @genres = Genre.where(id: Subgenre.all.pluck(:genre_id))
  end

  def create
    @car = Car.new(car_params)

    if @car.save
  # car_paramsで送られてきたkeyの中から、サブジャンルのidが入ったパラメータを文字列で検索して取得
    subgenre_ids = params[:car].keys.select {|key| key.include?("subgenre")}
    subgenre_ids.each do |subgenre_id|
  # 取得したkeyにサブジャンルが存在する場合、CarGenre内にレコードを(eachで全て)作成
      if params[:car][subgenre_id].present?
        CarGenre.create(subgenre_id: params[:car][subgenre_id], car_id: @car.id)
      end
    end
      redirect_to admin_car_path(@car.id), notice: "出品ID#{@car.id}を登録しました"
    else
      flash[:alert] = "登録に失敗しました"
      render :new
    end
  end

  def show
  end

  def edit
    #genres_ids = @car.subgenres.map{ |x| x.genre.id }
    @genres = Genre.where(id: Subgenre.all.pluck(:genre_id))
    #@subgenres = @car.subgenres
  end

  def update
    @genres = Genre.where(id: Subgenre.all.pluck(:genre_id))
    if @car.update(car_params)
      begin
        ActiveRecord::Base.transaction do
          update_car_genres
        end

        redirect_to admin_car_path(@car), notice: "出品ID#{@car.id}を更新しました"
      rescue => e
        Rails.logger.error "Failed to update car genres: #{e.message}"
        flash[:alert] = "出品ID#{@car.id}の更新に失敗しました"
        render :edit
      end
    else
      flash[:alert] = "出品ID#{@car.id}の更新に失敗しました"
      render :edit
    end
  end

  def destroy
    if @car.destroy
      redirect_to admin_cars_path, notice: "出品ID#{@car.id}を削除しました"
    else
      flash[:alert] = "出品ID#{@car.id}の削除に失敗しました"
      render :show
    end
  end

  private

  def car_params
    params.require(:car).permit(:name, :detail, :price, :color, :passenger_amount, :year, :chassis_code, :mileage, :is_km, :shaken_period, :shaken_finish, :grade, :engine_capacity, :transmission, :fuel, :is_available, images: [], subgenre_ids: [])
  end

  def car_genre
    params.require(:car_genre).permit(:subgenre_id, :car_id)
  end

  def find_car_id
    @car = Car.find(params[:id])
  end

  private

# 出品に登録されたサブジャンルを比較し、更新を行うメソッド
def update_car_genres
  # 更新前のサブジャンルのデータを取得（中間テーブルのレコード）
  pre_subgenre_ids = CarGenre.where(car_id: @car.id).pluck(:subgenre_id)
  # 更新後のパラメータから送られてきたサブジャンルを取得
  post_subgenre_ids = extract_subgenre_ids_from_params

  remove_old_car_genres(pre_subgenre_ids - post_subgenre_ids)
  create_new_car_genres((post_subgenre_ids - pre_subgenre_ids).reject { |id| id == "" })
  update_same_car_genres(post_subgenre_ids & pre_subgenre_ids)
end

# 文字列でパラメータ内を検索し、キーを取得して変数の代入したものをメソッド化
def extract_subgenre_ids_from_params
  subgenre_keys = params[:car].keys.select { |key| key.include?("subgenre") }
  subgenre_keys.map { |subgenre_key| params[:car][subgenre_key] }
end

# 不要になったサブジャンルの関連データを削除
def remove_old_car_genres(old_subgenre_ids)
  CarGenre.where(car_id: @car.id, subgenre_id: old_subgenre_ids).destroy_all
end

# 新しく追加されるサブジャンルは関連レコード新規作成
def create_new_car_genres(new_subgenre_ids)
  new_subgenre_ids.each do |subgenre_id|
    CarGenre.create(subgenre_id: subgenre_id, car_id: @car.id)
  end
end

# 同じ関連データの更新は更新処理のみ
def update_same_car_genres(same_subgenre_ids)
  same_car_genres = CarGenre.where(car_id: @car.id, subgenre_id: same_subgenre_ids)
  same_car_genres.each(&:save)
end

end
