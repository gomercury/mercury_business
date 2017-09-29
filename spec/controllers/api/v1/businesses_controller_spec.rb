require 'rails_helper'

RSpec.describe Api::V1::BusinessesController, type: :controller do
	let(:business) { FactoryGirl.create(:business) }
	let(:api_key) { FactoryGirl.create(:api_key, business_id: business.id) }

	describe "GET show" do
		context "with valid token" do
			it "returns business" do
				request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(api_key.access_token)
				get :show, params: { id: business.id }
				expect(response).to have_http_status(:ok)
				expect(JSON.parse(response.body)["id"]).to eq(business.id)
			end
		end

		context "with invalid token" do
			it "throws :unauthorized status code" do
				request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials("INVALID_TOKEN")
				get :show, params: { id: business.id }
				expect(response).to have_http_status(:unauthorized)
			end
		end

		context "with invalid business 'id'" do
			it "throws :not_found status code" do
				request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(api_key.access_token)
				get :show, params: { id: "INVALID_BUSINESS_ID" }
				expect(response).to have_http_status(:not_found)
			end
		end

		context "with non-matching token and business 'id'" do
			it "throws :unauthorized status code" do
				request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(api_key.access_token)
				alternate_business = FactoryGirl.create(:business)
				get :show, params: { id: alternate_business.id }
				expect(response).to have_http_status(:unauthorized)
			end
		end
	end

	describe "PUT update" do
		context "with valid token" do
			it "returns updated business" do
				request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(api_key.access_token)
				get :update, params: { id: business.id, business: { email: "newemail@gmail.com" } }
				expect(response).to have_http_status(:ok)
				expect(JSON.parse(response.body)["email"]).to eq("newemail@gmail.com")
			end
		end

		context "with invalid token" do
			it "returns :unauthorized status code" do
				request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials("INVALID_TOKEN")
				get :update, params: { id: business.id, business: { email: "newemail@gmail.com" } }
				expect(response).to have_http_status(:unauthorized)
			end
		end

		context "with invalid business 'id'" do
			it "returns :not_found status code" do
				request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(api_key.access_token)
				get :update, params: { id: "INVALID_BUSINESS_ID", business: { email: "newemail@gmail.com" } }
				expect(response).to have_http_status(:not_found)
			end
		end

		context "with non-matching token and business 'id'" do
			it "returns :unauthorized status code" do
				request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(api_key.access_token)
				alternate_business = FactoryGirl.create(:business)
				get :update, params: { id: alternate_business.id, business: { email: "newemail@gmail.com" } }
				expect(response).to have_http_status(:unauthorized)
			end
		end
	end
end
