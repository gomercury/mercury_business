class ApplicationController < ActionController::API
	respond_to :json

	protected

		def request_http_token_authentication(realm = "Application", message = nil)
		  self.headers["WWW-Authenticate"] = %(Token realm="#{realm.gsub(/"/, "")}")
		  render status: 401, json: {
				status: 401,
				errors: ["not authorized"],
			}
		end
end
