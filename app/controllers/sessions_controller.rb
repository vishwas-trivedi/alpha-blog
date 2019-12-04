class SessionsController < ApplicationController
  
  # Used to create session for user login
  def new
    
  end

  # Used to verify user login details
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    message = 'You have successfully logged in.'
    if user
      if !params[:session][:password].nil? && user.authenticate(params[:session][:password])
        flash[:success] = message
        session[:user_id] = user.id
        redirect_to user_path(user)
      else
        message = 'Invalid log in credentials'
        flash.now[:danger] = message
        render 'new'
      end
    else
      message = 'User with given email address does not exist.'
      flash.now[:danger] = message
      render 'new'
    end

  #   if user && user.authenticate(params[:session][:password])
  #     flash[:success] = 'You have successfully logged in.'
  #     session[:user_id] = user.id
  #     redirect_to user_path(user)
  #   else
  #     flash.now[:danger] = 'Something is wrong with you login information'
  #     render 'new'
  #   end
  end

  # Used to logout user
  def destroy
    session[:user_id] = nil
    flash[:success] = 'You have logged out.'
    redirect_to root_path
  end
end