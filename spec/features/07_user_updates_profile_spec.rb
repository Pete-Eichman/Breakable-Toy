require 'rails_helper'

feature "User updates their profile information" do
  let!(:users) { FactoryGirl.create_list(:user, 2) }
  before { login_as(users[0], scope: :user) }

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
      expect(page).to have_link("Back")
    end

    scenario "I can edit my account details on the edit page" do
      visit root_path
      click_link "My Profile"
      click_link "Edit User Account"
      fill_in("Email", with: "testemail01@gmail.com")
      fill_in("Password", with: "pass02")
      fill_in("Password confirmation", with: "pass02")
      fill_in("Current password", with: "#{users[0].password}")
      click_button "Update"

      expect(page).to have_content "Your account has been updated successfully"
    end
  end
  context "As a non-admin user on another user's page" do
    scenario "I cannot see a link to edit the user's page" do
      visit user_path(users[1])

      expect(page).to_not have_link "Edit User Account"
    end
  end
end
