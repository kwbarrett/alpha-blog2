require 'test_helper'

class SignupUserTest < ActionDispatch::IntegrationTest
  test 'Should sign up a new user' do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: 'snoopy', email: 'snoopy@example.org', password: 'password '} }
      follow_redirect!
    end
    assert_template 'users/show'
    assert_match 'snoopy', response.body
  end
end
