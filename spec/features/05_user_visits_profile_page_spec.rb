require 'rails_helper'

feature "User visits profile page" do
  let!(:user) { FactoryGirl.create(:user) }
  before { login_as(user, scope: :user) }
  context "As a user" do
    scenario "I can click on the My Profile link to view my profile." do
      visit root_path
      click_link "My Profile"


      expect(page).to have_link "My Profile"
      expect(page).to have_link "Sign Out"
      expect(page).to have_content "My Profile"
      expect(page).to have_link "Add A Parking Pass"
      expect(page).to have_link "Edit User Account"
      expect(page).to have_link "Delete User Account"
    end
  end
end
