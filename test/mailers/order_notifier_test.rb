require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
 fixtures :orders, :line_items, :products
  test "received" do
    mail = OrderNotifier.received(orders(:one))
    assert_equal "Store order Confirmation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(orders(:one))
    assert_equal "store order shipped", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
