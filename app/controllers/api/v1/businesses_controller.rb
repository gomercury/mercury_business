module Api
	module V1
		class BusinessesController < ApplicationController
			include ActionController::HttpAuthentication::Token::ControllerMethods
			before_action :restrict_access, except: [:create]
			respond_to :json

			def create
				business = Business.new(business_params)
				if business.save
					api_key = ApiKey.new(business_id: business.id)
					if api_key.save
						render status: 201, json: { 
							status: 201,
							business: business, 
							api_key: api_key,
						}
					else
						render status: 400, json: { 
							status: 400,
							errors: api_key.errors.full_messages,
							business: business,
						}
					end
				else
					render status: 400, json: { 
						status: 400,
						errors: business.errors.full_messages,
					}
				end
			end

			def show
				if business = Business.find_by_id(params[:id])
					if business == @business
						render status: 200, json: {
							status: 200,
							business: business,
						}
					else
						render status: 401, json: {
							status: 401,
							errors: ["not authorized"],
						}
					end
				else
					render status: 404, json: {
						status: 404,
						errors: ["business does not exist"],
					}
				end
			end

			def update
				if business = Business.find_by_id(params[:id])
					if business == @business
						if business.update_attributes(business_params)
							render status: 200, json: { 
								status: 200,
								business: business,
							}
						else
							render status: 400, json: { 
								status: 400,
								errors: business.errors.full_messages,
							}
						end
					else
						render status: 401, json: {
							status: 401,
							errors: ["not authorized"],
						}
					end
				else
					render status: 404, json: {
						status: 404,
						errors: ["business does not exist"],
					}
				end
			end

			def destroy
				if business = Business.find_by_id(params[:id])
					if business == @business
						if business.destroy
							render status: 200, json: {
								status: 200,
							}
						else
							render status: 400, json: { 
								status: 400,
								errors: business.errors.full_messages,
							}
						end
					else
						render status: 401, json: {
							status: 401,
							errors: ["not authorized"],
						}
					end
				else
					render status: 404, json: {
						status: 404,
						errors: ["business does not exist"],
					}
				end
			end

			private

				def restrict_access
					authenticate_or_request_with_http_token do |token, options|
						if api_key = ApiKey.find_by_access_token(token)
							@business = api_key.business
						elsif
							render status: 401, json: {
								status: 401,
								errors: ["not authorized"],
							}
							return
						end
					end
				end

				def business_params
					params.require(:business).permit(
						:name,
						:thumbnail,
						:email,
						:phone,
						:address,
						:longitude,
						:latitude,
						:description,
						:facebook,
						:instagram,
						:yelp,
						:twitter,
					)
				end
		end
	end
end
