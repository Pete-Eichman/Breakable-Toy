require 'rails_helper'

feature "User can create a parking pass" do
  let!(:user) { FactoryGirl.create(:user) }
  before { login_as(user, scope: :user) }

  context "As an authenticated user" do
    scenario "I can create a parking pass" do
      visit root_path
      click_link("My Profile")
      click_link("Add A Parking Pass")
      fill_in("Pass number", with: "S1234567")
      fill_in("Address", with: "10 Park Ave")
      fill_in("Price per hour", with: "$10.00")
      click_button("Create Parking Pass")

      expect(page).to have_link "My Profile"
      expect(page).to have_link "Sign Out"
      expect(page).to have_content "#{user.first_name}"
      expect(page).to have_content "#{user.last_name}'s Profile"
      expect(page).to have_content "#{user.last_name}'s Profile"
      expect(page).to have_link "Add A Parking Pass"
      expect(page).to have_link "Edit User Account"
      expect(page).to have_link "Delete User Account"
      expect(page).to have_content "#{user.parking_passes[0].pass_number}"
      expect(page).to have_content "#{user.parking_passes[0].address}"
    end
  end
end
