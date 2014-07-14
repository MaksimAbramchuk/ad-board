require 'spec_helper'
require 'cancan/matchers'

include CanCan::Ability

describe Ability do
  context 'When user is a common user' do
    let(:user) do
      User.new(email: 'test@gmail.com', password: 'password', password_confirmation: 'password', role: 'user')
    end

    subject(:ability) { Ability.new(user) }

    it { expect(ability).to be_able_to(:create, Advert.new) }
    it { expect(ability).to be_able_to(:edit, Advert.new(user: user)) }
    it { expect(ability).to be_able_to(:change_state, Advert.new(user: user)) }
    it { expect(ability).to be_able_to(:show, User.new) }
    it { expect(ability).to be_able_to(:account, User.new) }
    it { expect(ability).to be_able_to(:edit, User.new(id: user.id)) }
    it { expect(ability).to be_able_to(:change, User.new(id: user.id)) }

    it { expect(ability).not_to be_able_to(:awaiting_publication, Advert.new) }
    it { expect(ability).not_to be_able_to(:manage, Category.new) }
    it { expect(ability).not_to be_able_to(:manage, User.new) }
    it { expect(ability).not_to be_able_to(:change_role, User.new) }
  end

  context 'When user is an admin' do
    let(:user) do
      User.new(email: 'test1@gmail.com', password: 'password', password_confirmation: 'password', role: 'admin')
    end

    subject(:ability) { Ability.new(user) }

    it { expect(ability).to be_able_to(:change_state, Advert.new) }
    it { expect(ability).to be_able_to(:edit, Advert.new) }
    it { expect(ability).to be_able_to(:edit, User.new) }
    it { expect(ability).to be_able_to(:change_role, User.new) }
    it { expect(ability).to be_able_to(:manage, User.new) }
    it { expect(ability).to be_able_to(:manage, Category.new) }
  end
end
