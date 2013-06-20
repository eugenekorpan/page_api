class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def authorized?
    !!current_user
  end

  helper_method :authorized?
  helper_method :current_user

  private

  def authenticate_user
    render_404 unless authorized?
  end

  def render_404
    render 'public/404', status: 404 and return
  end
end
