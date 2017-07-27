require 'test_helper'

class UsermailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @usermail = usermails(:one)
  end

  test "should get index" do
    get usermails_url
    assert_response :success
  end

  test "should get new" do
    get new_usermail_url
    assert_response :success
  end

  test "should create usermail" do
    assert_difference('Usermail.count') do
      post usermails_url, params: { usermail: { content: @usermail.content, date: @usermail.date, from: @usermail.from, subject: @usermail.subject, to: @usermail.to } }
    end

    assert_redirected_to usermail_url(Usermail.last)
  end

  test "should show usermail" do
    get usermail_url(@usermail)
    assert_response :success
  end

  test "should get edit" do
    get edit_usermail_url(@usermail)
    assert_response :success
  end

  test "should update usermail" do
    patch usermail_url(@usermail), params: { usermail: { content: @usermail.content, date: @usermail.date, from: @usermail.from, subject: @usermail.subject, to: @usermail.to } }
    assert_redirected_to usermail_url(@usermail)
  end

  test "should destroy usermail" do
    assert_difference('Usermail.count', -1) do
      delete usermail_url(@usermail)
    end

    assert_redirected_to usermails_url
  end
end
