require 'rails_helper'

feature "User visits profile page" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:parking_pass) { FactoryGirl.create(:parking_pass, user: user) }
  before { login_as(user, scope: :user) }
  context "As a user who owns a parking pass" do
    scenario "I can see my parking passes" do
      visit root_path
      click_link "My Profile"

      expect(page).to have_link "#{parking_pass.address}"
      expect(page).to have_link "Edit Parking Pass"
      expect(page).to have_link "Delete Parking Pass"
    end
  end
end
