class SessionsController < ApplicationController
  skip_before_filter :authenticate_user

  def new
    @user = User.new
  end

  def create
    @user = User.where(params[:user]).first
    if @user
      session[:user_id] = @user.id
      flash[:notice] = 'Authentication successful'
      redirect_to main_path
    else
      flash[:error] = 'Authentication failed'
      redirect_to new_sessions_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_sessions_path
  end
end
