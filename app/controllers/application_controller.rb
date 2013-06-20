class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user

  def current_user
    @current_user ||= User.find_by_username_and_password(params[:username], params[:password])
  end

  def authorized?
    !!current_user
  end

  private

  def authenticate_user
    render 'public/404', status: 404 and return unless authorized?
  end
end
