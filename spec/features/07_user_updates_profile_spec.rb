require 'rails_helper'

feature "User updates their profile information" do
  let!(:user) { FactoryGirl.create(:user, password: "pass01", password_confirmation: "pass01") }
  before { login_as(user, scope: :user) }

  context "As an authenticated user on my profile page" do
    scenario "I can click a link to view my account edit page" do
      visit root_path
      click_link "My Profile"
      click_link "Edit User Account"

      expect(page).to have_content("Email")
      expect(page).to have_field("Email")
      expect(page).to have_content("Password")
      expect(page).to have_field("Password")
      expect(page).to have_content("Password confirmation")
      expect(page).to have_field("Password confirmation")
      expect(page).to have_content("Current password")
      expect(page).to have_field("Current password")
      expect(page).to have_button("Update")
      expect(page).to have_button("Cancel my account")
      expect(page).to have_link("Back")
    end

    scenario "I can edit my account details on the edit page" do
      visit root_path
      click_link "My Profile"
      click_link "Edit User Account"
      fill_in("Email", with: "testemail01@gmail.com")
      fill_in("Password", with: "pass02")
      fill_in("Password confirmation", with: "pass02")
      fill_in("Current password", with: "pass01")
      click_button "Update"

      expect(page).to have_content "Your account has been updated successfully"
    end
  end
end
