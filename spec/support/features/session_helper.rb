module Features
  module SessionHelper
    def sign_in_with(email, password)
      visit new_user_session_path
      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      page.find('input.button').click
    end
  end
end