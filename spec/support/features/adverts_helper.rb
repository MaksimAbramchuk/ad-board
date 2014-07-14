module Features
  module AdvertsHelper
    def click_sorting_link(field)
      within('.sidebar-nav') do
        click_link(field)
      end
    end

    def select_state(state)
      page.find('a.dropdown-toggle').click
      page.find_link('Change state').click
      select(state, from: 'advert_state')
    end
  end
end