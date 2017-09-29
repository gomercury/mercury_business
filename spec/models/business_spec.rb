require 'rails_helper'

RSpec.describe Business, type: :model do
  it "should have a valid factory" do
		business = FactoryGirl.create(:business)
		expect(business).to be_valid
	end
end
