class UsersController < ApplicationController
  def new
  	@user = User.new #creates a new user and stores it in the @user variable
  end

  def show
  	@user = User.find(params[:id]) #finds a user by their id # and stores it in the @user variable for use in a view
  end

  def create
  	@user = User.new(params[user_params]) #not the final implementation
  	if @user.save
  		#Handle a successeful save
  	else
  		render 'new' #if unsuccessful, renders new user page (i.e., signup flow)
  	end
  end

private
	
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation) #separates parameters into aspects that are required (users) and permitted entries (avoiding any others for security purposes)
	end

end
