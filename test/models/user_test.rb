require "test_helper"

VALID_EMAIL = %w[
  test@domain.com
  lastname@domain.com
  test.email.with+symbol@domain.com
  id-with-dash@domain.com
  a@domain.com (one-letter local part)
  "abc.test email"@domain.com
  "xyz.test.@.test.com"@domain.com
  "abc.(),:;<>[]\".EMAIL.\"email@\ \"email\".test"@strange.domain.com
  example-abc@abc-domain.com
  admin@mailserver1
  #!$%&'*+-/=?^_{}|~@domain.org
  “()<>[]:,;@\\”!#$%&’-/=?^_`{}| ~.a”@domain.org
  ” “@domain.org
  example@localhost
  example@s.solutions
  test@com
  test@localserver
  test@[IPv6:2018:db8::1]
]

INVALID_EMAIL = %w[
  example.com
  A@b@c@domain.com
  a”b(c)d,e:f;gi[j\k]l@domain.com
  abc”test”email@domain.com
  abc is”not\valid@domain.com
  abc\ is\”not\valid@domain.com
  .test@domain.com
  test@domain..com
]


class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name:"Example User",email:"User@example.com")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = '   '
    refute @user.valid?
  end

  test 'name should not be too long' do
    @user.name = "a" * 51
    refute @user.valid?

  end

  test "email should be present" do
    @user.email = '   '
    refute @user.valid?
  end

  test "email should be unique" do
    @user.save
    @new_user = User.new(name:'Another User',email:"User@example.com")
    refute @new_user.valid?
  end

  test "email should not be too long" do
    @user.email ="a"*256
    refute @user.valid?
  end

  test "email validation should accept valid email addresses" do
      VALID_EMAIL.each do |address|
      @user.email = address
      assert @user.valid?
    end
  end

end
