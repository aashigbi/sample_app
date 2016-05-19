
    require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
	assert @user.valid?
  end

  test "name should be present" do
	@user.name = '   '
	assert_not @user.valid?
  end

  test "email should be present" do
	@user.email = '   '
	assert_not @user.valid?
  end

  test "name should be less than 51 characters" do
	@user.name = 'a' * 51
	assert_not @user.valid?
  end

  test "email should be less than 255 characters" do
	@user.email = 'a' * 256 + '@gmail.com'
	assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
	valid_addresses = %w[user@example.com USER@foo.com A_US-ER@foo.bar.org]
	valid_addresses.each do |valid_address|
		@user.email = valid_address
		assert @user.valid?, "#{valid_addresses.inspect} should be valid"
	end
  end

  test "email validation should not accept valid addresses" do
	invalid_addresses = %w[user@example,com USER_at_foo.com user.name@exampl. foo@bar_baz.com foo@bar+baz.com foo@bar..com]
	invalid_addresses.each do |invalid_address|
		@user.email = invalid_address
		assert_not @user.valid?, "#{invalid_addresses.inspect} should not be valid"
	end
  end

  test "email addresses should be unique" do
  	duplicate_user = @user.dup
  	duplicate_user.email = @user.email.upcase
  	@user.save
  	assert_not duplicate_user.valid?
  end

  test "password should not be blank" do
    @user.password = @user.password_confirmation =  " " * 6
    assert_not @user.valid?
  end

  test "password should be longer than 6 characters" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "email addresses should be saved as lower case" do
    mixed_case_email = "Foo@ExaMpLe.cOm"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
   end 
end