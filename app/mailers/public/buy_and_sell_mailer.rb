class Public::BuyAndSellMailer < ApplicationMailer

  def new_buy_and_sell_email
    @appointment = params[:buy_and_sell]
    @buy_request = @appointment.buy_request
    @sell_request = @appointment.sell_request
    @sell_detail = @sell_request.sell_detail

    mail(
      to: ENV["EMAIL"],
      subject: "【購入・買取見積り】同時予約申し込み完了",
      bcc: @appointment.email
    )
  end

end
