require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
  self.use_instantiated_fixtures = true
  @user = users(:one)
  end
  test "should create a user" do
    assert_difference('User.count') do
    post :create, user: {name: 'sam', password: 'secret',
    password_confirmation: 'secret'}
   end
    assert_redirected_to users_path
  end

  test "should update user" do
    patch :update, id:@user, user:{name:@user.name, password: 'secret',
    password_confirmation: 'secret'}
  end

end
