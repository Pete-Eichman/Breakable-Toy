require 'rails_helper'

feature "User can logout" do
  let!(:user) { FactoryGirl.create(:user) }
  before { login_as(user, scope: :user) }

  context "As a user, after signing in" do
    scenario "I can click a link to logout" do
      visit '/'
      click_link("Sign Out")

      expect(page).to_not have_content("Signed in as")
      expect(page).to_not have_content("Signed in successfully.")
      expect(page).to have_content("Signed out successfully.")
      expect(page).to have_content("Login Email")
      expect(page).to have_field("Login Email")
      expect(page).to have_content("Login Password")
      expect(page).to have_field("Login Password")
      expect(page).to have_button("Sign in")
      expect(page).to have_link("Forgot your password?")
      expect(page).to have_link("Sign up")
      expect(page).to have_content("Remember me")
    end
  end
end
