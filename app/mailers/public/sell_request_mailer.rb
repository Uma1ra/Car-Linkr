class Public::SellRequestMailer < ApplicationMailer

  def new_sell_request_email(appointment, sell_request, sell_detail)
    @sell_request = sell_request
    @sell_detail = sell_detail
    @appointment = appointment

    mail(
      to: ENV["EMAIL"],
      subject: "【買取見積り】予約申し込み完了",
      bcc: @appointment.email
    )
  end

end
