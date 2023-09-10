class Public::CustomersController < ApplicationController

  def mypage
    @customer = current_customer
  end
  
  # def guest_login
  #   if current_customer
  #     redirect_to root_path, alert: "すでにログインしています"
  #     # ログインしている場合はゲストユーザーを作成しない
  #   else
  #     customer = Customer.guest_login
  #     customer.log_in
  #     redirect_to mypage_path, notice: "ゲストとしてログインしました"
  #   end
  # end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :post_code, :phone_number)
  end

end
