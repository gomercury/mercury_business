source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.6'
# Use postgres as database for Active Record. Read more: https://github.com/ged/ruby-pg
gem 'pg'
# Validate email format. Read more: https://github.com/validates-email-format-of/validates_email_format_of
gem 'validates_email_format_of'
# Validates phone number. Read more: https://github.com/daddyz/phonelib
gem 'phonelib'
# A set of Rails responders to dry up your application. Read more: https://github.com/plataformatec/responders
gem 'responders'

group :development, :test do
	# Load env variables from .env. Read more: https://github.com/bkeepers/dotenv
  gem 'dotenv-rails'
    # Generate fake data. Read more: https://github.com/stympy/faker
  gem 'faker'
  # Fixtures replacement. Read more: https://github.com/thoughtbot/factory_girl_rails
  gem 'factory_girl_rails', '~> 4.0', require: false
  # Run tests on file change. Read more: https://github.com/guard/guard-rspec
  gem 'guard-rspec', require: false
  # Testing framework. Read more: https://github.com/rspec/rspec-rails
  gem 'rspec-rails'
  # Clean database. Read more: https://github.com/DatabaseCleaner/database_cleaner
  gem 'database_cleaner'
end

group :development do
	# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
	gem 'spring'
	# Listens to file modifications and notifies you about the changes. Read more: https://github.com/guard/listen
	gem 'listen', '~> 3.0.5'
end
