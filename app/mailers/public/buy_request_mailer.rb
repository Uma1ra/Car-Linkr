class Public::BuyRequestMailer < ApplicationMailer

  def new_buy_request_email
    @buy_request = params[:buy_request]
    @appointment = @buy_request.appointment

    mail(
      to: ENV["EMAIL"],
      subject: "【購入見積り】予約申し込み完了",
      bcc: @buy_request.appointment.email
    )
  end

end
