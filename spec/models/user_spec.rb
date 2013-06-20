require 'spec_helper'

describe User do
  context 'validations' do
    subject { User.new }

    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:role) }
  end
end
