require 'rails_helper'

RSpec.describe Api::V1::BusinessesController, type: :controller do
	let(:business) { FactoryGirl.create(:business) }
	let(:api_key) { FactoryGirl.create(:api_key, business_id: business.id) }

	describe "POST create" do
		context "with valid attributes" do
			it "returns created business" do
				expect {
					get :create, params: { business: FactoryGirl.attributes_for(:business, name: "NEW_BUSINESS") }
				}.to change(Business, :count).by(1)

				status = JSON.parse(response.body)["status"]
				business = JSON.parse(response.body)["business"]

				expect(response).to have_http_status(201)
				expect(status).to eq(201)
				expect(business["name"]).to eq("NEW_BUSINESS")
			end
		end

		context "with invalid attributes" do
			it "throws 400 status code" do
				expect {
					get :create, params: { business: FactoryGirl.attributes_for(:business, name: nil) }
				}.to_not change(Business, :count)

				status = JSON.parse(response.body)["status"]
				errors = JSON.parse(response.body)["errors"]

				expect(response).to have_http_status(400)
				expect(status).to eq(400)
				expect(errors).to_not be_nil
			end
		end
	end

	describe "GET show" do
		context "with valid token" do
			it "returns business" do
				business_id = business.id
				request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(api_key.access_token)
				get :show, params: { id: business_id }
				
				status = JSON.parse(response.body)["status"]
				business = JSON.parse(response.body)["business"]

				expect(response).to have_http_status(200)
				expect(status).to eq(200)
				expect(business["id"]).to eq(business_id)
			end
		end

		context "with invalid token" do
			it "throws 401 status code" do
				request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials("INVALID_TOKEN")
				get :show, params: { id: business.id }
				expect(response).to have_http_status(401)
			end
		end

		context "with invalid business 'id'" do
			it "throws 404 status code" do
				request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(api_key.access_token)
				get :show, params: { id: "INVALID_BUSINESS_ID" }
				
				status = JSON.parse(response.body)["status"]
				errors = JSON.parse(response.body)["errors"]

				expect(response).to have_http_status(404)
				expect(status).to eq(404)
				expect(errors).to_not be_nil
			end
		end

		context "with non-matching token and business 'id'" do
			it "throws 401 status code" do
				request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(api_key.access_token)
				alternate_business = FactoryGirl.create(:business)
				get :show, params: { id: alternate_business.id }
				
				status = JSON.parse(response.body)["status"]
				errors = JSON.parse(response.body)["errors"]

				expect(response).to have_http_status(401)
				expect(status).to eq(401)
				expect(errors).to_not be_nil
			end
		end
	end

	describe "PUT update" do
		context "with valid token" do
			it "returns updated business" do
				request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(api_key.access_token)
				get :update, params: { id: business.id, business: { email: "newemail@gmail.com" } }
				
				status = JSON.parse(response.body)["status"]
				business = JSON.parse(response.body)["business"]

				expect(response).to have_http_status(200)
				expect(status).to eq(200)
				expect(business["email"]).to eq("newemail@gmail.com")
			end
		end

		context "with invalid token" do
			it "returns 401 status code" do
				request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials("INVALID_TOKEN")
				get :update, params: { id: business.id, business: { email: "newemail@gmail.com" } }
				expect(response).to have_http_status(401)
			end
		end

		context "with invalid business 'id'" do
			it "returns 404 status code" do
				request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(api_key.access_token)
				get :update, params: { id: "INVALID_BUSINESS_ID", business: { email: "newemail@gmail.com" } }
				
				status = JSON.parse(response.body)["status"]
				errors = JSON.parse(response.body)["errors"]

				expect(response).to have_http_status(404)
				expect(status).to eq(404)
				expect(errors).to_not be_nil
			end
		end

		context "with non-matching token and business 'id'" do
			it "returns 401 status code" do
				request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(api_key.access_token)
				alternate_business = FactoryGirl.create(:business)
				get :update, params: { id: alternate_business.id, business: { email: "newemail@gmail.com" } }
				
				status = JSON.parse(response.body)["status"]
				errors = JSON.parse(response.body)["errors"]

				expect(response).to have_http_status(401)
				expect(status).to eq(401)
				expect(errors).to_not be_nil
			end
		end
	end

		describe "DELETE destroy" do
		context "with valid token" do
			it "returns updated business" do
				request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(api_key.access_token)
				delete :destroy, params: { id: business.id }
				
				status = JSON.parse(response.body)["status"]

				expect(response).to have_http_status(200)
				expect(status).to eq(200)
			end
		end

		context "with invalid token" do
			it "returns 401 status code" do
				request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials("INVALID_TOKEN")
				delete :destroy, params: { id: business.id }
				expect(response).to have_http_status(401)
			end
		end

		context "with invalid business 'id'" do
			it "returns 404 status code" do
				request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(api_key.access_token)
				delete :destroy, params: { id: "INVALID_BUSINESS_ID" }
				
				status = JSON.parse(response.body)["status"]
				errors = JSON.parse(response.body)["errors"]

				expect(response).to have_http_status(404)
				expect(status).to eq(404)
				expect(errors).to_not be_nil
			end
		end

		context "with non-matching token and business 'id'" do
			it "returns 401 status code" do
				request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(api_key.access_token)
				alternate_business = FactoryGirl.create(:business)
				delete :destroy, params: { id: alternate_business.id }
				
				status = JSON.parse(response.body)["status"]
				errors = JSON.parse(response.body)["errors"]

				expect(response).to have_http_status(401)
				expect(status).to eq(401)
				expect(errors).to_not be_nil
			end
		end
	end
end
