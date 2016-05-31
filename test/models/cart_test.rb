require 'test_helper'

class CartTest < ActiveSupport::TestCase
  def setup
    @cart = carts(:cart_1)
    @product = products(:product_1)
    @product_2 = products(:ruby)
  end
  def add_price(p1,p2)
    p1 + p2
  end
  def mult_price(quan,p2)
    quan * p2
  end

  test "cart should increase quantity with duplicate product" do
    cart = Cart.new
    l2 = cart.add_product(@product.id)
    l = cart.add_product(@product_2.id)
    sz = cart.line_items.size
    assert_equal sz, 2
    tot = add_price(l.product.price, l2.product.price) 
    assert_equal cart.total_price, tot
  end
  
  test "should add unique products to cart" do
    cart = Cart.new
    line_item_2 = cart.add_product(@product.id) 
    line_item_2.save
    assert_equal cart.line_items.count, 1
    line_item = cart.add_product(@product.id) 
    line_item.save
    assert_equal cart.line_items.count, 1 
    assert_equal line_item.quantity, 2
    price = mult_price(line_item.quantity,line_item.product.price)
    assert_equal cart.total_price, price
  end
end
