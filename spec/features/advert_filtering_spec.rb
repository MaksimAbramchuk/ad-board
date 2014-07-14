require 'rails_helper'

feature 'Advert filtering' do

  let(:user) { Fabricate(:user) }

  before do
    sign_in_with(user.email, user.password)
  end

  scenario 'Should filter adverts by one param (kind)' do
    kinds = Advert.kind.options.map { |k| k.last }
    kinds.count.times { |i| Fabricate(:advert, kind: kinds[i]) }

    select 'Kind', from: 'q_c_0_a_0_name'
    fill_in 'q_c_0_v_0_value', with: 'Rent'
    page.find('input.btn-success').click

    expect(page).not_to have_content('Service')
  end

end