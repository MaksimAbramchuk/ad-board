require 'rails_helper'

feature 'State changing' do

  scenario 'Advert archiving' do
    advert = Fabricate(:advert, state: :published)
    user = advert.user
    
    sign_in_with(user.email, user.password)
    
    select_state('archive')
    click_button('Change state')
    
    expect(page).to have_content 'archived'
  end

  scenario 'Advert decline with comment', js: true do
    advert = Fabricate(:advert, state: :awaiting_publication)
    user = Fabricate(:user, role: 'admin')

    sign_in_with(user.email, user.password)
    
    visit awaiting_publication_adverts_path
    select_state('decline')
    fill_form(:comment, { comment: 'test_comment' })
    click_button('Change state')
    
    visit logs_advert_path(advert)
    expect(page).to have_content 'test_comment'
  end
end
