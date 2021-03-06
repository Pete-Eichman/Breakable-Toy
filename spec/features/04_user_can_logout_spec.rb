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
      expect(page).to have_content("Park-Me!")
      expect(page).to have_content("Signed out successfully.")
      expect(page).to have_content("Email")
      expect(page).to have_field("Email")
      expect(page).to have_content("Password")
      expect(page).to have_field("Password")
      expect(page).to have_button("Sign in")
      expect(page).to have_link("Forgot password?")
      expect(page).to have_link("Sign up")
      expect(page).to have_content("Remember me")
      expect(page).to have_content("Sign in with Facebook")
    end
  end
end
