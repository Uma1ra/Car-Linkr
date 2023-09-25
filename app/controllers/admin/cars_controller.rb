class Admin::CarsController < ApplicationController
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
      redirect_to admin_car_path(@car.id), notice: "出品#{@car.id}登録されました"
    else
      render :new, alert: "出品#{@car.id}登録に失敗しました"
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
    #   # 変更前の指定したcarに紐づくsubgenre_idを全て取得する
    #   pre_subgenre_ids = CarGenre.where(car_id: @car.id).pluck(:subgenre_id)
    #   # 更新で送られてきたパラメータを全て取得
    #   subgenre_keys = params[:car].keys.select {|key| key.include?("subgenre")}
    #   # 種痘されたパラメータの値を取得
    #   post_subgenre_ids = subgenre_keys.map { |subgenre_key| params[:car][subgenre_key] }

    #   # ["1",   "", "24"]古
    #   # [ "", "10", "24"]新

    #   # 上だけに含まれるもの ⇒ 削除
    #   old_subgenre_ids = (pre_subgenre_ids - post_subgenre_ids)
    #   old_car_genres = CarGenre.where(car_id: @car.id, subgenre_id: old_subgenre_ids)
    #   old_car_genres.each do |old|
    #     old.destroy
    #   end
    #   # 下だけに含まれるもの ⇒ 新規作成
    #   # post_subgenre_idsには空白も含まれ、不要なのでrejectで除外
    #   new_subgenre_ids = (post_subgenre_ids - pre_subgenre_ids).reject { |id| id == "" }
    #   new_subgenre_ids.each do |subgenre_id|
    #     CarGenre.create(subgenre_id: subgenre_id, car_id: @car.id)
    #   end
    #   # 上と下で共通するもの ⇒ 更新
    #   same_subgenre_ids = post_subgenre_ids & pre_subgenre_ids
    #   same_car_genres = CarGenre.where(car_id: @car.id, subgenre_id: same_subgenre_ids)
    #   same_car_genres.each do |same|
    #     same.save
    #   end

        redirect_to admin_car_path(@car), notice: "更新しました"
      rescue => e
        Rails.logger.error "Failed to update car genres: #{e.message}"
        render :edit, alert: "更新に失敗しました"
      end
    else
      render :edit, alert: "更新に失敗しました"
    end
  end

  def destroy
    if @car.destroy
      redirect_to admin_cars_path, notice: "出品#{@car.id}を削除しました"
    else
      render :show, alert: "削除に失敗しました"
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
