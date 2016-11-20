require 'rails_helper'

feature "User can book a parking pass" do
  let!(:users) { FactoryGirl.create_list(:user, 2) }
  let!(:parking_pass) { FactoryGirl.create(:parking_pass, user: users[1]) }
  before { login_as(users[0], scope: :user) }
  context "An authenticated user who has visited a parking pass page" do
    scenario "User click the Create a Booking link and sees the new booking page" do
      visit parking_pass_path(parking_pass)
      click_link "Create a Booking"


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
  context "As an authenticated user who has visited the Booking page" do
    scenario "User successfully creates a booking" do
      visit parking_pass_path(parking_pass)
      click_link "Create a Booking"
      fill_in("booking[first_name]", with: "#{users[0].first_name}")
      fill_in("booking[last_name]", with: "#{users[0].last_name}")
      fill_in("booking[phone_number]", with: "#{users[0].phone_number}")
      fill_in("booking[start_time]", with: "12:00 PM")
      fill_in("booking[end_time]", with: "4:00 PM")
      fill_in("booking[date]", with: "01/20/2017")
      click_button "Create Booking"

    end
  end
end
