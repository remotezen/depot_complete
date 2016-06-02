require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  def setup
    @ruby_book = products(:ruby)
  end
  test "user test buying products" do
    get "/"
    assert_response :success
    assert_template "index"
    xml_http_request :post, '/line_items', product_id: @ruby_book.id
    assert_response :success
    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal @ruby_book, cart.line_items[0].product
    post_via_redirect "/orders",
      order: {name: orders(:one).name,
              address: orders(:one).address,
              email: orders(:one).email,
              pay_type: "Check"}
    assert_template "index"
    cart = Cart.find(session[:cart_id])
    assert 0, cart.line_items.size
    orders = Order.all
    order = orders[0]
    assert_equal "Fred Hudson", order.name
    assert_equal "My Text", order.address
    assert_equal "email@email.org", order.email
    assert_equal "Check", order.pay_type
    assert_equal 2, order.line_items.size
    line_item = order.line_items[0]
    assert_equal @ruby_book, line_item.product
  end
end
