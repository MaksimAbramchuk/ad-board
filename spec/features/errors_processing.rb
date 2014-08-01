require 'rails_helper'

feature 'Error' do
  let(:user) { Fabricate(:user) }

  before(:each) do
    sign_in_with(user.email, user.password)
  end

  context 'ActiveRecord::RecordNotFound' do
    scenario 'raises record_not_found' do 
      visit user_path(20)
      expect(current_path).to eq(root_path)
      expect(page).to have_content('Record has not been found')
    end
  end

  context 'CanCan::AccessDenied' do
    scenario 'raises user_not_authorized' do
      visit categories_path
      expect(current_path).to eq(root_path)
      expect(page).to have_content('You are not authorized to access this')
    end
  end
end
