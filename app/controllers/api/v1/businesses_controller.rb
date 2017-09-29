module Api
	module V1
		class BusinessesController < ApplicationController
			include ActionController::HttpAuthentication::Token::ControllerMethods
			before_action :restrict_access
			respond_to :json

			def show
				if business = Business.find_by_id(params[:id])
					if business == @business
						render status: :ok, json: business
					else
						render status: :unauthorized
					end
				else
					render status: :not_found
				end
			end

			def update
				if business = Business.find_by_id(params[:id])
					if business == @business
						if business.update_attributes(business_params)
							render status: :ok, json: business
						else
							render status: :bad_request, json: { errors: business.errors.full_messages }
						end
					else
						render status: :unauthorized
					end
				else
					render status: :not_found
				end
			end

			private

				def restrict_access
					authenticate_or_request_with_http_token do |token, options|
						if api_key = ApiKey.find_by_access_token(token)
							@business = api_key.business
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
