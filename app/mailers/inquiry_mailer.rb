class InquiryMailer < ApplicationMailer
  def send_formmail(profile, inquiry)
    @inquiry = inquiry
    mail(
      to: inquiry.profile.user.email,
      subject: "【MinePage】フォームメール受信のお知らせ",
      reply_to: inquiry.email
    )
  end
end
