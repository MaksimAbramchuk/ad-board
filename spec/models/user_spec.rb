require 'spec_helper'

describe User do
  let(:user) do
    User.new(email: 'test@gmail.com', name: 'test', password: 'password', password_confirmation: 'password')
  end

  describe 'presence' do
    
    subject { user }

    %w(email name password password_confirmation).each do |field|
      it { should respond_to(field.to_sym) }
    end
  end

  describe 'validations' do
    it { expect(subject).to validate_presence_of(:email) }
    it { expect(subject).to validate_presence_of(:name) }
  end

  describe 'associations' do
    it { expect(subject).to have_many(:adverts) }
    it { expect(subject).to have_one(:avatar) }
  end

end
