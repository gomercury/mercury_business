class Business < ApplicationRecord
	# validations
  validates :name, presence: true
  validates :thumbnail, presence: true
  validates :email, presence: true
  validates_email_format_of :email
  validates :phone, presence: true, phone: { possible: true }
  validates :address, presence: true
  validates :longitude, presence: true, numericality: true
  validates :latitude, presence: true, numericality: true
  validates :description, presence: true

  # relationships
  has_many :api_keys
end
