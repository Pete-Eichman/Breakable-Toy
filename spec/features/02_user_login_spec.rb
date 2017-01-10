require 'rails_helper'

feature "As an unauthenticated user, I can log in" do
  before { visit root_path }
  let!(:user) { FactoryGirl.create(:user, first_name: "FirstName1", last_name: "LastName1", password: "password1", password_confirmation: "password1") }
  context "User visits the home page" do
    scenario "User sees a page with login information" do
      expect(page).to have_content("Email")
      expect(page).to have_field("Email")
      expect(page).to have_content("Password")
      expect(page).to have_field("Password")
      expect(page).to have_button("Sign in")
      expect(page).to have_link("Forgot password?")
      expect(page).to have_link("Sign up")
      expect(page).to have_content("Remember me")
      expect(page).to have_css("#fb_icon")
    end

    scenario "User successfully logs in" do
      fill_in("Email", with: user.email)
      fill_in("Password", with: user.password)
      check("Remember me")
      click_button("Sign in")
      page.find('i#person_pin')
      page.find('i#power_off')

      expect(page).to have_link("My Profile")
      expect(page).to have_link("Sign Out")
      expect(page).to have_css("i#person_pin")
      expect(page).to have_css("i#power_off")
      expect(page).to have_link("Find Parking")
      expect(page).to_not have_content("Email")
      expect(page).to_not have_field("Email")
      expect(page).to_not have_content("Password")
      expect(page).to_not have_field("Password")
      expect(page).to_not have_button("Sign in")
      expect(page).to_not have_link("Forgot password?")
      expect(page).to_not have_content("Remember me")
    end

    scenario "User attempts to log in with a nonexistent account" do
      fill_in("Email", with: "unregistered_user@gmail.com")
      fill_in("Password", with: "unregistered_password")
      check("Remember me")
      click_button("Sign in")

      expect(page).to have_content("Sign Up")
      expect(page).to have_content("First name")
      expect(page).to have_field("First name")
      expect(page).to have_content("Last name")
      expect(page).to have_field("Last name")
      expect(page).to have_content("Phone number")
      expect(page).to have_field("Phone number")
      expect(page).to have_content("Email")
      expect(page).to have_field("Email")
      expect(page).to have_content("Password")
      expect(page).to have_field("Password")
      expect(page).to have_content("Password confirmation")
      expect(page).to have_field("Password confirmation")
      expect(page).to have_button("Sign Up")
    end

    scenario "User attempts to log in with an incorrect password" do
      fill_in("Email", with: user.email)
      fill_in("Password", with: "password2")
      click_button("Sign in")

      expect(page).to have_content("Email")
      expect(page).to have_field("Email")
      expect(page.find("#user_email")['value']).to eq(user.email)
      expect(page).to have_content("Password")
      expect(page).to have_field("Password")
      expect(page).to have_button("Sign in")
      expect(page).to have_link("Sign up")
      expect(page).to have_link("Sign in with Facebook")
      expect(page).to have_link("Forgot your password?")
      expect(page).to have_content("Remember me")
    end
    scenario "User can see a Facebook login link" do

      expect(page).to have_link("Facebook")
    end
  end
end
