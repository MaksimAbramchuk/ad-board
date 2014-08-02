require 'rails_helper'

feature 'Error' do
  let(:user) { Fabricate(:user) }

  context 'ActiveRecord::RecordNotFound' do
    scenario 'raises record_not_found' do 
      sign_in_with(user.email, user.password)
      visit user_path(20)
      expect(current_path).to eq(root_path)
      expect(page).to have_content('Record has not been found')
    end
  end

  context 'CanCan::AccessDenied' do
    scenario 'raises user_not_authorized' do
      sign_in_with(user.email, user.password)
      visit categories_path
      expect(current_path).to eq(root_path)
      expect(page).to have_content('You are not authorized to access this')
    end
  end

  context 'Destrict with error' do
    before do
      category = Fabricate(:category)
      Fabricate(:advert, category: category)

      admin = Fabricate(:user, role: 'admin')
      sign_in_with(admin.email, admin.password)
    end

    scenario "can't delete category with adverts" do
      visit categories_path
      click_link('Destroy')

      expect(page).to have_content('Some errors have occured while deleting')
    end
  end
end
