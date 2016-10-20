require 'rails_helper'

feature "User visits word page" do
  let!(:user) { FactoryGirl.create(:user) }
  before { login_as(user, scope: :user) }
  context "As a user" do
    scenario "I can click on the My Profile link to view my profile." do
      visit root_path
      click_link "My Profile"

      expect(page).to have_content user.first_name
      expect(page).to have_content user.last_name
    end
  end
end
