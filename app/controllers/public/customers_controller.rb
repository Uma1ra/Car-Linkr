class Public::CustomersController < ApplicationController

  def mypage
    @customer = current_customer
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :post_code, :phone_number)
  end

end
