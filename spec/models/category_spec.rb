require 'spec_helper'

describe Category do

  describe 'associations' do
    it { expect(subject).to have_many(:adverts) }
  end

  describe 'validations' do
    it { expect(subject).to validate_presence_of(:name) }
  end

end
