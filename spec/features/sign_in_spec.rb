require 'rails_helper'

RSpec.describe "Sign Up", :type => :features do
  it "Should Sign Up Me" do
    visit('users/sign_up')
    fill_in "Email", with: "test@gmail.com"
    fill_in 'user_password', with: "somepassword"
    fill_in 'user_password_confirmation', with: "somepassword"
    sign_up_button = find_button 'Sign up'
    click_on(sign_up_button)
    expect(page).to have_content 'Hello'
  end
end
