require 'spec_helper'

describe Sale do

  include Factories

  it "should have a valid indication of wether the sale is unlimited or not" do
    s = Sale.new
    s.save
    s.should have(1).error_on(:is_unlimited)
  end

  it "should have a valid zip code" do
    s = Sale.new
    s.save
    s.should have(1).error_on(:zip_code)
  end

  it "should have a end date posterior to the start date" do
    today = Date.today
    in_the_past = Date.today - 3

    s = Sale.new(:start_time => today, :end_time => in_the_past)
    s.save

    s.should have(1).error_on(:end_time)
  end

  it "should be possible to associate a sale to a user" do
    sale = factory_build :valid_unlimited_sale
    user = factory_create :valid_user

    sale.user = user
    sale.save!

    sale.reload.user.token.should be_eql(user.token)
  end

  it "should have a latitude and longitude" do
    sale = factory_build :valid_unlimited_sale

    sale.longitude = nil
    sale.latitude  = nil

    sale.should have(1).error_on(:longitude)
    sale.should have(1).error_on(:latitude)
  end
end
