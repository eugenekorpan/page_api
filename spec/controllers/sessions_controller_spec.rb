require 'spec_helper'

describe SessionsController do

  context '.create' do
    it 'should fail authentiaction' do
      post :create, user: { username: 'invalid', password: 'invalid' }
      flash[:error].should_not be_empty
      response.should redirect_to(new_sessions_path)
      session[:user_id].should be_blank
    end

    it 'should authenticate user' do
      user = FactoryGirl.create(:user)
      post :create, user: { username: user.username, password: user.password }
      flash[:notice].should_not be_empty
      response.should redirect_to(main_path)
      session[:user_id].should == user.id
    end
  end

end
