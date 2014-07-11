require 'rails_helper'

RSpec.describe 'Advert Functional', type: :features do

  it 'Should Add New Advert' do
    @category = Fabricate(:category)
    visit new_user_session_path
    fill_in 'user_email', with: Fabricate(:user).email
    fill_in 'user_password', with: Fabricate(:user).password
    page.find('input.button').click
    visit('adverts/new')
    fill_in 'advert_name', with: 'test_advert_name'
    fill_in 'advert_description', with: 'test_description'
    fill_in 'advert_price', with: '1000'
    select(@category.name, from: 'advert_category_id')
    page.find('input.btn').click
    expect(page).to have_content 'test_advert_name'
  end

  it 'Should Edit Advert' do
    @advert = Fabricate(:advert)
    @user = @advert.user
    visit new_user_session_path
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    page.find('input.button').click
    visit edit_advert_path(@advert)
    fill_in 'advert_name', with: 'test_advert_name'
    page.find('input.btn').click
    visit users_adverts_path
    expect(page).to have_content 'test_advert_name'
  end

end