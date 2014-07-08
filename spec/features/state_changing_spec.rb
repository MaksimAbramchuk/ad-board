require 'rails_helper'

RSpec.describe 'Advert sorting', type: :features do

  it 'Should sort adverts by price' do
    @user = Fabricate(:user)
    @adverts = 20.times.map { Fabricate(:advert) }.each { |a| a.price = a.id; a.save }
    smallest_price = Advert.first.price
    highest_price = Advert.last.price
    visit new_user_session_path
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    page.find('input.button').click
    page.find_link('Price').click
    expect(page).to have_content smallest_price
    page.find_link('Price').click
    expect(page).to have_content highest_price
  end

  it 'Should sort adverts by date' do
    @user = Fabricate(:user)
    @adverts = 20.times.map { Fabricate(:advert) }.each { |a| a.updated_at+=a.id; a.save }
    oldest_advert_time = Advert.first.updated_at.strftime(' %m/%d/%Y at %T')
    newest_advert_time = Advert.last.updated_at.strftime(' %m/%d/%Y at %T')
    visit new_user_session_path
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    page.find('input.button').click
    page.find_link('Date').click
    save_and_open_page
    expect(page).to have_content oldest_advert_time
    page.find_link('Date').click
    expect(page).to have_content newest_advert_time
  end

end