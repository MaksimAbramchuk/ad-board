require 'rails_helper'

feature 'Advert sorting' do
  let(:user) { Fabricate(:user) }

  before(:each) do
    sign_in_with(user.email, user.password)
  end

  context 'Sorting by price' do
    before do
      Fabricate(:advert, name: 'Low', price: 10)
      Fabricate(:advert, name: 'High', price: 100)
    end

    scenario 'In ascending order' do
      click_sorting_link('Price')

      expect(page.body).to have_content_in_order('Low', 'High')
    end

    scenario 'In descending order' do
      2.times { click_sorting_link('Price') }

      expect(page.body).to have_content_in_order('High', 'Low')
    end
  end

  context 'Sorting by updated_at' do
    before do
      Fabricate(:advert, name: 'New', updated_at: 1.day.ago)
      Fabricate(:advert, name: 'Old', updated_at: 2.days.ago)
    end

    scenario 'In ascending order' do
      click_sorting_link('Date')
      expect(page.body).to have_content_in_order('New', 'Old')
    end
  end

end