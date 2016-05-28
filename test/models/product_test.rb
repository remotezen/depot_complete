require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end
  test "product price must be positive" do
    product = Product.new(title:"new Product",
                         description: "yyy",
                         image_url: "xxx.png")
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
      product.errors[:price]
    product.price = 1
    assert product.valid?
  end
  def new_product(image_url)
    Product.new(title: "My book title",
               description: "xxx",
               price: 1,
               image_url: image_url
               )
  end
  test "image url" do
    good = %w[fred.jpg fred.png fred.gif]
    bad = %w[fred.www fred.xgg fred.pgnw ]
    good.each do |g|
      assert new_product(g).valid?, "#{g} should be valid"
    end
    bad.each do |g|
      assert new_product(g).invalid?, "#{g} shouldn't be valid"
    end
  end
    
    test "product is not valid without a unique title" do
      product = Product.new(title: products(:ruby).title,
                           description: "yyy",
                           price: 1,
                           image_url: "fred.jpg"
                           )
      assert product.invalid?
      assert_equal ["has already been taken"], product.errors[:title]

  end
end
