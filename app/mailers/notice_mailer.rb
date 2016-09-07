class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.senmail_blog.subject
  #
  def sendmail_blog(blog)
    @blog = blog

    mail to: "robopowerful_vv@yahoo.co.jp",
    subject: "【Achieve】ブログが投稿されました"
  end
end
