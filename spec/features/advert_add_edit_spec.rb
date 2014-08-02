require 'rails_helper'

feature 'Advert Functional' do
  context 'Adding new advert' do
    before do
      user = Fabricate(:user)
      sign_in_with(user.email, user.password)
    end
    
    scenario 'with valid params' do
      category = Fabricate(:category)
      visit new_advert_path
      fill_form(:advert, { name: 'test_advert_name',
                           description: 'test_description',
                           price: '1000',
                           category: category.name
                         })

      page.find('input.btn').click
      
      expect(page).to have_content 'The advert has been successfully added'
    end

    scenario 'with invalid params' do
      visit new_advert_path
      fill_form(:advert, { name: ''})
      page.find('input.btn').click
      expect(page).to have_content "Name can't be blank"
    end
  end

  context 'Editing advert' do
    before do
      advert = Fabricate(:advert)
      user = advert.user
      sign_in_with(user.email, user.password)
      visit edit_advert_path(advert)
    end

    scenario 'with valid params' do
      fill_form(:advert, { name: 'test_advert_name' })
      page.find('input.btn').click
    
      expect(page).to have_content 'The advert has been successfully updated'
    end

    scenario 'with invalid params' do
      fill_form(:advert, { name: '' })
      page.find('input.btn').click

      expect(page).to have_content "Name can't be blank"
    end
  end

end
