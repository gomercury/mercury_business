Rails.application.routes.draw do
  namespace :api do
  	namespace :v1 do
  		resources :businesses, only: [:show, :update]
  	end
  end
end
