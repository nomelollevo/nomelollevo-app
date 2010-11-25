require 'spec_helper'

describe Sale do
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
end
