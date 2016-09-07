# Preview all emails at http://localhost:3000/rails/mailers/notice_mailer
class NoticeMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notice_mailer/senmail_blog
  def senmail_blog
    NoticeMailer.senmail_blog
  end

end
