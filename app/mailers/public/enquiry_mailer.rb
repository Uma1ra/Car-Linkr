class Public::EnquiryMailer < ApplicationMailer

  def new_enquiry_email(enquiry)
    @enquiry = enquiry

    mail(
      to: ENV["EMAIL"],
      subject: "お問い合わせがありました"
    )
  end

end
