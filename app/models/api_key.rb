class ApiKey < ApplicationRecord
	before_create :generate_access_token

	# validations
	validates :business_id, presence: true, numericality: true

	# relationships
	belongs_to :business

	private

		def generate_access_token
			begin
				self.access_token = SecureRandom.hex
			end while self.class.exists?(access_token: access_token)
		end
end
