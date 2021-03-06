require 'spec_helper'

describe User do

  include Factories

  it "should have a non empty email and nick" do
    u = User.new
    u.save
    u.should have(1).error_on(:nick)
    u.should have(2).error_on(:email)
  end

  it "should not allow users without tokens" do
    u = User.new
    u.save

    u.should have(1).error_on(:token)
  end

  it "should not allow duplicated emails" do
    u1 = User.new(:email => "a@test.com", :nick => "a", :token => "tokena")
    u2 = User.new(:email => "a@test.com", :nick => "b", :token => "tokenb")

    u1.save
    u2.save

    u1.should be_valid
    u2.should have(1).error_on(:email)
  end

  it "should allow only valid emails" do
    u = User.new(:email => "not_valid", :nick => "a", :token => "token")
    u.should_not be_valid

    u.email = "ua@test.com"
    u.should be_valid
  end

  it "should be possible to associate any number of sales" do
    u = factory_create :valid_user
    s1 = factory_build :valid_unlimited_sale
    s2 = factory_build :valid_unlimited_sale

    u.sales << s1
    u.sales << s2
    u.save!

    u.reload

    u.sales.should have(2).sales
  end
end
