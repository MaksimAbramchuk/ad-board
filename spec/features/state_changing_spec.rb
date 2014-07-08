require 'rails_helper'

RSpec.describe 'State changing', type: :features do

  it 'Should archive adverts' do
    @advert = Fabricate(:advert)
    @user = @advert.user
    visit new_user_session_path
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    page.find('input.button').click
    page.find('a.dropdown-toggle').click
    page.find_link('Change state').click
    select('archive', from: 'advert_state')
    page.find('input.btn-success').click
    expect(page).to have_content 'archived'
  end

  it 'Should decline advert with comment', js: true do
    @advert = Fabricate(:advert) { state 'awaiting_publication' }
    @user = @advert.user
    visit new_user_session_path
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    page.find('input.button').click
    visit awaiting_publication_adverts_path
    page.find('a.dropdown-toggle').click
    page.find_link('Change state').click
    select('decline', from: 'advert_state')
    fill_in 'advert_comment', with: 'test_comment'
    page.find_button('Change state').click
    visit logs_advert_path(@advert)
    expect(page).to have_content 'test_comment'
  end
end