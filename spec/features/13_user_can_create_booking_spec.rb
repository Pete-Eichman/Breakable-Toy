require 'rails_helper'

feature "User visits profile page" do
  let!(:users) { FactoryGirl.create_list(:user, 2) }
  let!(:parking_pass) { FactoryGirl.create(:parking_pass, user: users[1]) }
  before { login_as(users[0], scope: :user) }
  context "As a user" do
    scenario "I can click a link to bring me to the create booking page" do
      visit user_path(users[1])
      click_link "#{parking_pass.address}"
      click_link "Create a Booking"
      save_and_open_page

      expect(page).to have_link "My Profile"
      expect(page).to have_link "Sign Out"
      expect(page).to have_link "Search For Parking"
      expect(page).to have_content "First name"
      expect(page).to have_field "booking[first_name]"
      expect(page).to have_content "Last name"
      expect(page).to have_field "booking[last_name]"
      expect(page).to have_content "Phone number"
      expect(page).to have_field "booking[phone_number]"
      expect(page).to have_content "Start time"
      expect(page).to have_field "booking[start_time]"
      expect(page).to have_content "End time"
      expect(page).to have_field "booking[end_time]"
      expect(page).to have_content "Date"
      expect(page).to have_field "booking[date]"
      expect(page).to have_button "Create Booking"
    end
  end
end
