# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :reject_deleted_customer, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  def guest_login
    customer = Customer.guest
    sign_in customer

    if params[:car_id]
      @car = Car.find(params[:car_id])
      if params[:buy]
        redirect_to new_buy_request_path(car_id: @car.id)
      elsif params[:buy_and_sell]
        redirect_to new_buy_and_sell_path(car_id: @car.id)
      else
      end

    else
      redirect_to mypage_path, notice: "ゲストユーザーとしてログインしました"
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  # #   current_customer.is_guest
  # #   current_customer.destroy!
  #     super
  # end

  def after_sign_in_path_for(resource)
     mypage_path
  end

  def after_sign_out_path_for(resource)
     root_path
  end

  protected

  def reject_deleted_customer
    @customer = Customer.find_by(email: params[:customer][:email])
    if @customer
      if @customer.valid_password?(params[:customer][:password]) && (@customer.is_deleted == true)
        flash[:alert] = "退会済みです。再度登録をしてご利用ください。"
        redirect_to new_customer_registration_path
      elsif @customer.valid_password?(params[:customer][:password]) == false
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

end
