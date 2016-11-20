require 'rails_helper'

feature "User visits profile page and deletes their profile" do
  let!(:users) { FactoryGirl.create_list(:user, 2) }
  before { login_as(users[0], scope: :user) }
  before { visit root_path }
  context "As a User on My Profile page" do
    scenario "I can click a link to delete my account" do
      click_link "My Profile"
      click_link "Delete User Account"

      expect(page).to have_content "User Account successfully deleted."
      expect(page).to have_content "Welcome to ParkMe!"
      expect(page).to have_content "Please Sign In Below:"
      expect(page).to have_field "user[email]"
      expect(page).to have_field "user[password]"
      expect(page).to have_button "Sign in"
      expect(page).to have_link "Forgot your password?"
      expect(page).to have_content "OR"
      expect(page).to have_link "Sign up"
      expect(page).to have_link "Sign in with Facebook"
    end
  end
  context "As a non-admin user on another users profile page" do
    scenario "I cannot see a link to delete their account" do
      visit user_path(users[1])

      expect(page).to_not have_link "Edit User Account"
      expect(page).to_not have_link "Delete User Account"
    end
  end
end
