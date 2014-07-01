require 'rails_helper'

RSpec.describe 'Add and Edit Advert', type: :features do
  it 'Should Add New Advert' do
  	visit('users/sign_up')
    fill_in "Email", with: "test@gmail.com"
    fill_in 'user_password', with: "somepassword"
    fill_in 'user_password_confirmation', with: "somepassword"
    click_on 'Sign up'

    visit('adverts/new')
    fill_in 'advert_name', with: 'test_advert_name'
    fill_in 'advert_description', with: 'test_description'
    fill_in 'advert_price', with: '1000'
    click_on 'Submit'
    
    expect(page).to have_content 'test_advert_name'
  end

  it 'Should Edit New Advert'
end
