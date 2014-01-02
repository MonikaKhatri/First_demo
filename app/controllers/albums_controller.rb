class AlbumsController < ApplicationController

	def index
		@user = User.find(params[:user_id])
		if @user == current_user
			@albums= Album.where("user_id = ? ",params[:user_id])
		elsif @user.following?(current_user) and current_user.following?(@user)
			@albums = Album.where("user_id = ? and privacy = ? or privacy = ?",params[:user_id],"Visible to Friends","Public")
		else
			@albums = Album.where("user_id = ? and privacy = ?",params[:user_id],"public")
		end
		if @user.oauth_token != nil
			@fbuser = FbGraph::User.me(@user.oauth_token)
      		@fbalbums = @fbuser.albums
      	end
	end

	def new
		@album = Album.new
		@album.photos.build unless @album.photos.present?
	end

	def create
		@album = Album.new(album_params)
		@album.user_id = current_user.id
		if @album.save
			redirect_to user_albums_path(current_user.id), :notice => "Album Created..!!"
		else
			render :action => "new"		
		end 
	end

	def show
		@user = User.find(params[:user_id])
		if @user.oauth_token != nil
			@fbuser = FbGraph::User.me(@user.oauth_token)
      		@fbalbums = @fbuser.albums
      		@album = @fbalbums.detect{|a| a.identifier == params[:id]}
      	else
      		@album = Album.find(params[:id])
		end

		@photos = @album.photos

	end

	def edit
		@album = Album.find(params[:id])
		@album.photos.build unless @album.photos.present?
	end

	def update
		@album = Album.find(params[:id])
		if @album.update_attributes(album_params)
			flash[:success] = "Album Updated"
			redirect_to user_album_path(current_user.id,@album)
		else
			render 'edit'
		end
	end

	def destroy
		if params[:photo_id]
			Photo.find(params[:photo_id]).destroy
			redirect_to user_album_path(params[:user_id],params[:id]) 
		else
			Album.find(params[:id]).destroy
			flash[:success] = "User deleted"
			redirect_to user_albums_path(params[:user_id]) 
		end
	end

	def album_params
    	params.require(:album).permit(:name, :privacy, :photos_attributes => [:name,:pic])
  	end
end