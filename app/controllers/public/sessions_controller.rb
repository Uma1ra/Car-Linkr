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
    redirect_to mypage_path, notice: "ゲストユーザーとしてログインしました"
  end

  # DELETE /resource/sign_out
  # def destroy
  #   current_customer.is_guest
  #   current_customer.destroy!
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
      end
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

end
