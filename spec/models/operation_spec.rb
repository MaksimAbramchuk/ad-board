require 'spec_helper'

describe Operation do
  
  let(:operation) do
    Operation.new(advert_id: 1, user_id: 1, from: 'published', to: 'archived')
  end

  describe 'presence' do
    
    subject { operation }

    %w(advert_id user_id from to).each do |field|
      it { should respond_to(field.to_sym) }
    end
  end

end
