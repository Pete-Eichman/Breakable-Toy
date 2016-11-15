require 'rails_helper'

feature "User visits profile page" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:parking_pass) { FactoryGirl.create(:parking_pass, user: user) }
  before { login_as(user, scope: :user) }
  context "As a user who owns a parking pass" do
    scenario "I can see my parking passes" do
      visit root_path
      click_link "My Profile"

      expect(page).to have_link "#{parking_pass.address}"
      expect(page).to have_link "Edit Parking Pass"
      expect(page).to have_link "Delete Parking Pass"
    end
    scenario "I can click a link to bring me to my parking pass show page." do
      visit root_path
      click_link "My Profile"
      click_link "#{parking_pass.address}"

      expect(page).to have_content "Bookings:"
      expect(page).to have_link "Create a Booking"
    end
    scenario "I can click a link to bring me to the parking pass edit page" do
      visit root_path
      click_link "My Profile"
      click_link "Edit Parking Pass"
      save_and_open_page

      expect(page).to have_button "Update Parking Pass"
      expect(page).to have_field "parking_pass[pass_number]"
    end
  end
end
