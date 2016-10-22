require 'rails_helper'

feature "User visits parking passes page" do
  let!(:users) { FactoryGirl.create_list(:user, 2) }
  let!(:parking_pass) { FactoryGirl.create(:parking_pass, user: users[0]) }
  context "As an authenticated user" do
    scenario "I can click on a link bringing me to the parking pass index page." do
      login_as(users[1], scope: :user)
      visit root_path
      save_and_open_page
      click_link("Parking Passes")

      expect(page).to have_content parking_pass.address
      expect(page).to have_content parking_pass.pass_number
    end
  end
end
