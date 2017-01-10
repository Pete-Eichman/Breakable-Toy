require 'rails_helper'

feature "User can create a parking pass" do
  let!(:user) { FactoryGirl.create(:user) }
  before { login_as(user, scope: :user) }
  before { visit root_path }

  context "As an authenticated user I can click a link to add a parking pass" do
    scenario "User clicks Add Parking Pass button to navigate to new parking pass page" do
      click_link("My Profile")
      click_link("Add Parking Pass")

      expect(page).to have_link "My Profile"
      expect(page).to have_link "Sign Out"
      expect(page).to have_link "Find Parking"
      expect(page).to have_content "Add A Parking Pass"
      expect(page).to have_content "Pass number"
      expect(page).to have_content "Address"
      expect(page).to have_content "Price per hour"
      expect(page).to have_button "Create Pass"
      expect(page).to have_field "parking_pass[pass_number]"
      expect(page).to have_field "parking_pass[address]"
      expect(page).to have_field "parking_pass[price_per_hour]"
    end
    scenario "User fills forms correctly" do
      click_link("My Profile")
      click_link("Add Parking Pass")
      fill_in("Pass number", with: "S1234567")
      fill_in("Address", with: "10 Park Ave Worcester MA")
      fill_in("Price per hour", with: 2.00)
      click_button("Create Pass")

      expect(page).to have_link "My Profile"
      expect(page).to have_link "Sign Out"
      expect(page).to have_content "#{user.first_name}"
      expect(page).to have_content "My Profile"
      expect(page).to have_link "Add Parking Pass"
      expect(page).to have_link "Edit User Account"
      expect(page).to have_link "Delete User Account"
      expect(page).to have_content "#{user.parking_passes[0].pass_number}"
      expect(page).to have_content "#{user.parking_passes[0].address}"
    end
    scenario "User enters unmappable address and sees an error" do
      click_link "My Profile"
      click_link "Add Parking Pass"
      fill_in("Pass number", with: "S1234567")
      fill_in("Address", with: "gzrprzrp")
      fill_in("Price per hour", with: 2.00)
      click_button("Create Pass")

      expect(page).to have_content "Parking Pass could not be mapped, please enter a valid address."
      expect(page).to_not have_content "#{user.first_name}"
      expect(page).to_not have_link "Add Parking Pass"
      expect(page).to_not have_link "Edit User Account"
      expect(page).to_not have_link "Delete User Account"
    end
  end
end
