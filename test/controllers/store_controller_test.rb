require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  fixtures :products
  test "should get index" do
    get :index
    assert_response :success
    assert_select 'h1', "Your Pragmatic Catalog"
    assert_select 'ul.menu li a', 4
    assert_select 'span.price', /\$[,\d]+\.\d\d/
    assert_select 'h3', products(:ruby).title
    assert_select 'div.col-md-6.text-left.col-md-push-2.entry'
  end

end
