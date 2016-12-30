require 'rails_helper'

feature "Admin can edit another user's profile" do
  let!(:admin) {FactoryGirl.create(:admin)}
  let!(:users) { FactoryGirl.create_list(:user, 2) }
  before { login_as(admin, scope: :user) }
  context "As an Admin on another user's page" do
    scenario "I can see a link to the edit user page" do
      visit user_path(users[1])

      expect(page).to have_content "#{users[1].first_name}'s Profile"
      expect(page).to have_link "Edit User Account"
    end
    scenario "I click the link to navigate to the edit user page" do
      visit user_path(users[1])
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
  end
  context "As an Admin on another User's edit page" do
    scenario "I successfully update account details on the edit page" do
      visit user_path(users[1])
      click_link "Edit User Account"
      fill_in("Email", with: "testemail01@gmail.com")
      fill_in("Password", with: "pass02")
      fill_in("Password confirmation", with: "pass02")
      fill_in("Current password", with: "#{users[1].password}")
      click_button "Update"

      expect(page).to have_content "Your account has been updated successfully."
      expect(page).to have_content "Welcome To ParkMe!"
      expect(page).to have_content "Enjoy!"
    end
    scenario "I enter a password that's too short" do
      visit user_path(users[1])
      click_link "Edit User Account"
      fill_in("Email", with: "testemail01@gmail.com")
      fill_in("Password", with: "pass1")
      fill_in("Password confirmation", with: "pass1")
      fill_in("Current password", with: "#{users[1].password}")
      click_button "Update"

      expect(page).to have_content "Edit Your Account"
      expect(page).to have_content "1 error prohibited this user from being saved:"
      expect(page).to have_content "Password is too short (minimum is 6 characters)"
      expect(page).to_not have_content "Your account has been updated successfully."
    end
    scenario "I enter an incorrect current password" do
      visit user_path(users[1])
      click_link "Edit User Account"
      fill_in("Email", with: "testemail01@gmail.com")
      fill_in("Password", with: "pass02")
      fill_in("Password confirmation", with: "pass02")
      fill_in("Current password", with: "notpassword01")
      click_button "Update"

      expect(page).to have_content "Edit Your Account"
      expect(page).to have_content "1 error prohibited this user from being saved:"
      expect(page).to have_content "Current password is invalid"
      expect(page).to_not have_content "Your account has been updated successfully."
    end
    scenario "I enter mis-matching passwords" do
      visit user_path(users[1])
      click_link "Edit User Account"
      fill_in("Email", with: "testemail01@gmail.com")
      fill_in("Password", with: "pass03")
      fill_in("Password confirmation", with: "pass02")
      fill_in("Current password", with: "#{users[1].password}")
      click_button "Update"

      expect(page).to have_content "Edit Your Account"
      expect(page).to have_content "1 error prohibited this user from being saved:"
      expect(page).to have_content "Password confirmation doesn't match Password"
      expect(page).to_not have_content "Your account has been updated successfully."
    end
    scenario "I enter an invalid email address" do
      visit user_path(users[1])
      click_link "Edit User Account"
      fill_in("Email", with: "pblxq")
      fill_in("Password", with: "pass02")
      fill_in("Password confirmation", with: "pass02")
      fill_in("Current password", with: "#{users[1].password}")
      click_button "Update"

      expect(page).to have_content "Edit Your Account"
      expect(page).to have_content "1 error prohibited this user from being saved:"
      expect(page).to have_content "Email is invalid"
      expect(page).to_not have_content "Your account has been updated successfully."
    end
  end
end
