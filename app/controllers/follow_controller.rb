class FollowController < ApplicationController

  def show
  	@user = User.find(params[:user_id])
  	if params[:info] == "following"
  		@follow = @user.all_following
  	elsif params[:info] == "followers"
  		@follow = @user.followers
  	end
  end

  def create
  	@user = User.find(params[:user_id])
  	current_user.follow(@user)
  	redirect_to user_path(@user)
  end

  def destroy
  	@user = User.find(params[:user_id])
  	current_user.stop_following(@user)
  	redirect_to user_path(@user)
  end
end
