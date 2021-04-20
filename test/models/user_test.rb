require 'test_helper'

VALID_EMAIL = %w[
  user@example.com
  USER@foo.COM
  A_US-ER@foo.bar.org
  first.last@foo.jp
  alice+bob@baz.cn
].freeze

INVALID_EMAIL = %w[
  user@example,com
  foo@bar..com
  user_at_foo.org
  user.name@example.
  foo@bar_baz.com
  foo@bar+baz.com
].freeze

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Example User', email: 'User@example.com')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = '   '
    refute @user.valid?
  end

  test 'name should not be too long' do
    @user.name = 'a' * 51
    refute @user.valid?
  end

  test 'email should be present' do
    @user.email = '   '
    refute @user.valid?
  end

  test 'email should not be too long' do
    @user.email = 'a' * 256
    refute @user.valid?
  end

  test 'email should be unique case' do
    @user.save
    duplicate_user = @user.dup
    refute duplicate_user.valid?
  end

  test 'email should be downcased before saving to database ' do
    @user.email.upcase!
    @user.save
    assert @user.email == @user.email.downcase
  end

  test 'email validation should accept valid email addresses' do
    VALID_EMAIL.each do |address|
      @user.email = address
      assert @user.valid?, "#{address} should be valid"
    end
  end

  test 'email validation should refute invalid email addresses' do
    INVALID_EMAIL.each do |address|
      @user.email = address
      refute @user.valid?, "#{address} should be invalid"
    end
  end
end
