class SessionsController < ApplicationController
	include Devise::Controllers::Helpers
  def create
  	user = User.from_omniauth(env["omniauth.auth"])
  	session[:user_id] = user.id
  	sign_in user, :bypass => true
  	redirect_to root_url
  end
end
