require 'rails_helper'

feature "User visits the home page" do
  context "As an unauthenticated user" do
    scenario "I can view the home page" do
      visit '/'

      expect(page).to have_content "ParkMe!"
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
end
