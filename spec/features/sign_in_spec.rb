require 'rails_helper'

RSpec.describe 'Sign Up', type: :features do
  it 'Should Sign Up Me' do
    visit('users/sign_up')
    fill_in 'user_name', with: 'test_name'
    fill_in 'user_email', with: 'email@gmail.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    page.find('input.button').click
    expect(page).to have_content 'Hello'
  end
end
