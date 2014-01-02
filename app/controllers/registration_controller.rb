class RegistrationController < ApplicationController
	def new
		@user = User.new
	end   

	def create
		@user=User.new(user_params)
		if @user.save?
			sign_in @user
			flash[:success] = "Welcome to Mini fb"
			redirect_to root_path
		else
			render 'new'
		end
	end

	def update
		@user = User.find params[:id]

		if @user.update_attributes params[:user]
			flash[:notice] = 'The User is successfully updated!'
			redirect_to user_path
		else
			flash[:error] = @user.errors.full_messages[0]
			redirect_to edit_user_registration_path
		end
	end

	private
	
	def user_params
    	params.require(:user).permit(:name, :email, :location, :password, :password_confirmation)
  	end
end
