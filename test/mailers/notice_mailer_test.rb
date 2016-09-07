require 'test_helper'

class NoticeMailerTest < ActionMailer::TestCase
  test "senmail_blog" do
    mail = NoticeMailer.senmail_blog
    assert_equal "Senmail blog", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
