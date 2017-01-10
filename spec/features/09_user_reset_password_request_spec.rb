require 'rails_helper'

feature "User can reset password" do
  before { visit root_path }
  context "As a user, I forgot my password" do
    scenario "and I see a password reset link " do

      expect(page).to have_link("Forgot password?")
    end

    scenario "I can navigate to the password reset form" do
      click_link "Forgot password?"

      expect(page).to have_content("Forgot your password?")
      expect(page).to have_content("Email")
      expect(page).to have_field("Email")
      expect(page).to have_link("Sign in with Facebook")
      expect(page).to have_button("Send reset password instructions")
    end
  end
end
