require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  it "should have a valid factory" do
  	api_key = FactoryGirl.create(:api_key)
  	expect(api_key).to be_valid
  end
end
