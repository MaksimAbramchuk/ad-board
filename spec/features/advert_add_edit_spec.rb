require 'rails_helper'

feature 'Advert Functional' do

  scenario 'Adding new advert' do
    user = Fabricate(:user)
    category = Fabricate(:category)

    sign_in_with(user.email, user.password)

    visit new_advert_path
    fill_form(:advert, { name: 'test_advert_name',
                         description: 'test_description',
                         price: '1000',
                         category: category.name })
    page.find('input.btn').click

    expect(page).to have_content 'test_advert_name'
  end

  scenario 'Editing advert' do
    advert = Fabricate(:advert)
    user = advert.user

    sign_in_with(user.email, user.password)

    visit edit_advert_path(advert)
    fill_form(:advert, { name: 'test_advert_name' })
    page.find('input.btn').click
    
    visit users_adverts_path
    expect(page).to have_content 'test_advert_name'
  end

end
