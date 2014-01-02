class HomeController < ApplicationController
	
	def index
		@user = User.paginate(page: params[:page], per_page: 12).search(params[:search])
	end
end
