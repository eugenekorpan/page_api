require 'spec_helper'

describe Page do
  context 'validations' do
    subject { Page.new }

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:user_id) }
  end

  context '#published?' do
    it 'should be unpublished' do
      FactoryGirl.create(:unpublished_page).should_not be_published
    end

    it 'should be published' do
      FactoryGirl.create(:published_page).should be_published
    end

    context 'should be unpublished' do
      it 'for blank published_on' do
        page = FactoryGirl.create(:page, published_on: false)
        page.should_not be_published
      end

      it 'should test something' do
        page = FactoryGirl.create(:page, published_on: Date.tomorrow)
        page.should_not be_published
      end
    end

    context 'should be published' do
      it 'for published_on in the past' do
        page = FactoryGirl.create(:page, published_on: Date.yesterday)
        page.should be_published
      end
    end
  end

  context '#publish!' do
    let(:page) { FactoryGirl.create(:page, published_on: false) }

    it 'should publish the page' do
      page.should_not be_published
      page.publish!
      page.should be_published
    end
  end

  context '#total_words' do
    let(:page) { FactoryGirl.create(:page, title: 'two words', content: 'here goes four words') }

    it 'should return total number of words (title and content)' do
      page.total_words.should == 6
    end
  end

  context 'scopes' do
    subject { Page }

    before do
      3.times { FactoryGirl.create(:published_page) }
      2.times { FactoryGirl.create(:unpublished_page) }
    end

    context '.published' do
      it 'should return number of published pages' do
        subject.published.size.should == 3
      end
    end

    context '.unpublished' do
      it 'should return number of unpublished pages' do
        subject.unpublished.size.should == 2
      end
    end
  end

end
