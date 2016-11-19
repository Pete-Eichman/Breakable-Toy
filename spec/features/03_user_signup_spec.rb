require 'rails_helper'

feature "As an unregistered user, I can create an account" do
  let!(:existing_user) { FactoryGirl.create(:user, first_name: "firstname01", last_name: "lastname01", phone_number: "123-456-7890") }
  let!(:existing_user_email) { FactoryGirl.create(:user, email: "email01@gmail.com") }
  before { visit new_user_registration_path }

  context "User visits home page" do
    scenario "User clicks a link to navigate to Sign Up page" do
      visit root_path
      click_link("Sign up")

      expect(page).to_not have_content("Log In")
      expect(page).to_not have_content("Welcome to ParkMe!")
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
  end
  context "User successfully signs up at Sign Up page" do
    scenario "User fills out all fields correctly" do
      fill_in("First name", with: "firstname02")
      fill_in("Last name", with: "lastname02")
      fill_in("Phone number", with: "987-654-3210")
      fill_in("Email", with: "email02@gmail.com")
      fill_in("Password", with: "abcedf")
      fill_in("Password confirmation", with: "abcedf")
      click_button("Sign Up")

      expect(page).to_not have_content("First name")
      expect(page).to_not have_field("First name")
      expect(page).to_not have_content("Last name")
      expect(page).to_not have_field("Last name")
      expect(page).to_not have_content("Phone number")
      expect(page).to_not have_field("Phone number")
    end
  end

  context "User provides incomplete information at Sign Up page" do
    scenario "User leaves first name blank" do
      fill_in("First name", with: "")
      fill_in("Last name", with: "lastname")
      fill_in("Phone number", with: "222-222-2222")
      fill_in("Email", with: "22@gmail.com")
      fill_in("Password", with: "222222")
      fill_in("Password confirmation", with: "222222")
      click_button("Sign Up")

      expect(page).to have_content("First name can't be blank")
      expect(page).to_not have_content("Last name can't be blank")
      expect(page).to_not have_content("Email can't be blank")
      expect(page).to_not have_content("Password can't be blank")
      expect(page).to_not have_content("Password confirmation doesn't match Password")
    end

    scenario "User leaves last name blank" do
      fill_in("First name", with: "firstname")
      fill_in("Last name", with: "")
      fill_in("Phone number", with: "222-222-2222")
      fill_in("Email", with: "22@gmail.com")
      fill_in("Password", with: "222222")
      fill_in("Password confirmation", with: "222222")
      click_button("Sign Up")

      expect(page).to_not have_content("First name can't be blank")
      expect(page).to have_content("Last name can't be blank")
      expect(page).to_not have_content("Email can't be blank")
      expect(page).to_not have_content("Password can't be blank")
      expect(page).to_not have_content("Password confirmation doesn't match Password")
    end

    scenario "User leaves password blank" do
      fill_in("First name", with: "firstname")
      fill_in("Last name", with: "lastname")
      fill_in("Phone number", with: "222-222-2222")
      fill_in("Email", with: "22@gmail.com")
      fill_in("Password", with: "")
      fill_in("Password confirmation", with: "222222")
      click_button("Sign Up")

      expect(page).to_not have_content("First name can't be blank")
      expect(page).to_not have_content("Last name can't be blank")
      expect(page).to_not have_content("Email can't be blank")
      expect(page).to have_content("Password can't be blank")
      expect(page).to have_content("Password confirmation doesn't match Password")
    end

    scenario "User leaves password confirmation blank" do
      fill_in("First name", with: "firstname")
      fill_in("Last name", with: "lastname")
      fill_in("Phone number", with: "222-222-2222")
      fill_in("Email", with: "22@gmail.com")
      fill_in("Password", with: "222222")
      fill_in("Password confirmation", with: "")
      click_button("Sign Up")

      expect(page).to_not have_content("First name can't be blank")
      expect(page).to_not have_content("Last name can't be blank")
      expect(page).to_not have_content("Email can't be blank")
      expect(page).to_not have_content("Password can't be blank")
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end
  context "User provides invalid information at Sign Up page" do
    scenario "User provides invalid email" do
      fill_in("First name", with: "firstname")
      fill_in("Last name", with: "lastname")
      fill_in("Phone number", with: "222-222-2222")
      fill_in("Email", with: "@gmail.com")
      fill_in("Password", with: "222222")
      fill_in("Password confirmation", with: "222222")
      click_button("Sign Up")

      expect(page).to_not have_content("First name can't be blank")
      expect(page).to_not have_content("Last name can't be blank")
      expect(page).to have_content("Email is invalid")
      expect(page).to_not have_content("Password can't be blank")
      expect(page).to_not have_content("Password confirmation doesn't match Password")
    end

    scenario "User provides invalid password" do
      fill_in("First name", with: "firstname")
      fill_in("Last name", with: "lastname")
      fill_in("Phone number", with: "222-222-2222")
      fill_in("Email", with: "22@gmail.com")
      fill_in("Password", with: "2")
      fill_in("Password confirmation", with: "2")
      click_button("Sign Up")

      expect(page).to_not have_content("First name can't be blank")
      expect(page).to_not have_content("Last name can't be blank")
      expect(page).to_not have_content("Email can't be blank")
      expect(page).to have_content("Password is too short (minimum is 6 characters)")
      expect(page).to_not have_content("Password confirmation doesn't match Password")
    end

    scenario "User provides invalid password that doesn't match confirmation" do
      fill_in("First name", with: "firstname")
      fill_in("Last name", with: "lastname")
      fill_in("Phone number", with: "222-222-2222")
      fill_in("Email", with: "22@gmail.com")
      fill_in("Password", with: "2")
      fill_in("Password confirmation", with: "1")
      click_button("Sign Up")

      expect(page).to_not have_content("First name can't be blank")
      expect(page).to_not have_content("Last name can't be blank")
      expect(page).to_not have_content("Email can't be blank")
      expect(page).to have_content("Password is too short (minimum is 6 characters)")
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end
end
