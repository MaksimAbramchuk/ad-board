require 'spec_helper'

describe Advert do

  let(:advert) do
    Advert.new(name: 'test', description: 'test', price: 10000, kind: 'Rent', user_id: 1, category_id: 1)
  end

  describe 'presence' do

    subject { advert }

    %w(name description price kind user_id category_id).each do |field|
      it { should respond_to(field.to_sym) }
    end
  end

  describe 'associations' do
    it { expect(subject).to have_many(:images).dependent(:destroy) }
    it { expect(subject).to belong_to(:category) }
    it { expect(subject).to belong_to (:user) }
  end

  describe 'validations' do
    it { expect(subject).to validate_presence_of(:name) }
    it { expect(subject).to validate_presence_of(:description) }
    it { expect(subject).to validate_presence_of(:user_id) }
    it { expect(subject).to validate_presence_of(:category_id) }
  end

end
