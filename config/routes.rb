Rails.application.routes.draw do
  namespace :api do
  	namespace :v1 do
  		resources :businesses, only: [:create, :show, :update]
  	end
  end
end
