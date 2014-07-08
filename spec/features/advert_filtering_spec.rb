require 'rails_helper'

RSpec.describe 'Advert filtering', type: :features do

  it 'Should filter adverts by one param (kind)' do
    @user = Fabricate(:user)
    kinds = Advert.kind.options.map { |k| k.last }
    kinds.count.times { |i| Fabricate(:advert) { kind kinds[i] } }
    visit new_user_session_path
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    page.find('input.button').click
    select 'Kind', from: 'q_c_0_a_0_name'
    fill_in 'q_c_0_v_0_value', with: 'Rent'
    page.find('input.btn-success').click
    expect(page).not_to have_content('Service')
  end

end