require 'spec_helper'

describe Comment do

  let(:comment) do
    Comment.new(comment: 'test', advert_id: 1, operation_id: 1)
  end

  describe 'presence' do
    
    subject { comment }

    %w(comment advert_id operation_id).each do |field|
      it { should respond_to(field.to_sym) }
    end
  end

  describe 'associations' do
    it { expect(subject).to belong_to(:advert) }
    it { expect(subject).to belong_to (:operation) }
  end

end
