require 'rails_helper'

RSpec.describe 'Advert Functional', type: :features do
  it 'Should Add New Advert' do
    visit('users/sign_up')
    fill_in 'user_name', with: 'test_name'
    fill_in 'user_email', with: 'email@gmail.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    page.find('input.button').click

    visit('adverts/new')
    fill_in 'advert_name', with: 'test_advert_name'
    fill_in 'advert_description', with: 'test_description'
    fill_in 'advert_price', with: '1000'
    page.find('input.btn').click
    
    expect(page).to have_content 'test_advert_name'
  end

end
