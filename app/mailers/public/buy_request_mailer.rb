class Public::BuyRequestMailer < ApplicationMailer

  def new_buy_request_email(appointment, buy_request)
    @appointment = appointment
    @buy_request = buy_request

    mail(
      to: ENV["EMAIL"],
      subject: "【購入見積り】予約申し込み完了",
      bcc: @appointment.email
    )
  end

end