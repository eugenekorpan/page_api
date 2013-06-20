require 'spec_helper'

describe Api::PagesController do
  before do
    @request.env["HTTP_ACCEPT"] = 'application/json'
  end

  context 'authentication' do
    context '404' do
      it 'without credentials provided' do
        get :index
        response.status.should == 404
      end

      it 'with invalid credentials' do
        get :index, username: 'invalid_username', password: 'invalid_password'
        response.status.should == 404
      end
    end

    #context 'success' do
      #let(:user) { FactoryGirl.create(:user) }

      #it 'should return for valid user' do
        #get :index, username: user.username, password: user.password
        #response.should be_success
      #end
    #end
  end

  describe 'http' do
    let(:user) { FactoryGirl.create(:user) }

    before do
      controller.stub(:current_user).and_return(user)
    end

    context '.publish' do
      it 'should publish specific page' do
        page = FactoryGirl.create(:unpublished_page)
        get :publish, id: page.id
        page.reload
        page.should be_published
      end
    end

    context '.published' do
      it 'should return all published pages' do
        3.times { FactoryGirl.create(:published_page) }
        @expected = Page.published.desc.to_json

        get :published

        response.body.should eq(@expected)
      end
    end

    context '.unpublished' do
      it 'should return all published pages' do
        2.times { FactoryGirl.create(:unpublished_page) }
        @expected = Page.unpublished.desc.to_json

        get :unpublished

        response.body.should eq(@expected)
      end
    end

    context '.total_words' do
      it 'should return total number of words for specific page' do
        page = FactoryGirl.create(:page)
        get :total_words, id: page.id
    
        returned_value = JSON.parse(response.body)['total_words']

        returned_value.should == page.total_words
      end
    end
  end

end
