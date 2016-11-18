require 'rails_helper'

feature "User visits the map page" do
  let!(:users) { FactoryGirl.create_list(:user, 2) }
  let!(:parking_pass) { FactoryGirl.create(:parking_pass, user: users[0]) }
  context "As an authenticated user" do
    scenario "I can click on a link bringing me to the map page." do
      login_as(users[1], scope: :user)
      visit maps_path

      click_link("Search For Parking")
      parent = page.find('div#floating-panel')

      expect(parent).to have_css('#submit')
      expect(page).to have_content('Search')
    end
  end
end
