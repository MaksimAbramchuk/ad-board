require 'spec_helper'

describe Image do

  describe 'associations' do
    it { expect(subject).to belong_to(:imageable) }
  end

end
