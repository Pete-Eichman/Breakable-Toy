require 'rails_helper'

feature "User visits profile page and sees their parking pass" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:parking_pass) { FactoryGirl.create(:parking_pass, user: user) }
  before { login_as(user, scope: :user) }
  context "As a user who owns a parking pass" do
    scenario "I can see my parking passes" do
      visit root_path
      click_link "My Profile"

      expect(page).to have_link "#{parking_pass.address}"
      expect(page).to have_link "Edit Pass"
      expect(page).to have_link "Delete Pass"
    end
    scenario "I can click a link to bring me to my parking pass show page." do
      visit root_path
      click_link "My Profile"
      click_link "#{parking_pass.address}"

      expect(page).to have_content "Bookings:"
      expect(page).to have_link "Create a Booking"
    end
    scenario "I can click a link to delete my parking pass" do
      visit root_path
      click_link "My Profile"
      click_link "Delete Pass"

      expect(page).to have_content "Parking Pass was deleted!"
      expect(page).to have_link "My Profile"
      expect(page).to have_link "Sign Out"
      expect(page).to have_link "Search For Parking"
      expect(page).to have_link "Edit User Account"
      expect(page).to have_link "Add Parking Pass"
      expect(page).to have_link "Delete User Account"
      expect(page).to have_content "#{user.first_name}'s owned Parking Passes:"
      expect(page).to have_content "#{user.first_name}'s Bookings:"
      expect(page).to_not have_link "#{parking_pass.address}"
      expect(page).to_not have_link "Edit Pass"
      expect(page).to_not have_link "Delete Pass"
    end
  end
end
