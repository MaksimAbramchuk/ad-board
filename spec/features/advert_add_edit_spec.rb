require 'rails_helper'

RSpec.describe 'Add and Edit Advert', type: :features do
  it 'Should Add New Advert' do
  	visit('users/sign_up')
    fill_in 'Email', with: 'email@gmail.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    page.find('input.button').click

    visit('adverts/new')
    fill_in 'advert_name', with: 'test_advert_name'
    fill_in 'advert_description', with: 'test_description'
    fill_in 'advert_price', with: '1000'
    click_on 'Submit'
    
    expect(page).to have_content 'test_advert_name'
  end

  it 'Should Edit New Advert' do
    visit 'users/sign_in/'
    fill_in 'user_email', with: 'user0@gmail.com'
    fill_in 'user_password', with: 'password' 
    page.find('input.btn').click
    visit('account/adverts')
    page.first('a.btn').click
    expect(page).to have_content 'Update'
    fill_in 'advert_name', with: 'test_advert_name'
    click_on 'Update'
    expect(page).to have_content 'test_advert_name'
  end
end
