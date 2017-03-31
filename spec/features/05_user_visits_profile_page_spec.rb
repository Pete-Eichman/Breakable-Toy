require 'rails_helper'

feature "User visits profile page" do
  let!(:users) { FactoryGirl.create_list(:user, 2) }
  before { login_as(users[0], scope: :user) }
  context "As a user" do
    scenario "I can click on the My Profile link to view my profile." do
      visit user_path(users[0])

      expect(page).to have_link("My Profile")
      expect(page).to have_link("Sign Out")
      expect(page).to have_link("+")
      expect(page).to have_link("Edit Account")
      expect(page).to have_link ("Delete Account")
      expect(page).to have_content ("#{users[0].first_name}'s Profile")
      expect(page).to have_content ("#{users[0].first_name}'s Bookings:")
    end
    scenario "If I visit another User's profile, I get a limited view" do
      visit user_path(users[1])

      expect(page).to have_link("Home")
      expect(page).to have_link("My Profile")
      expect(page).to have_link("Sign Out")
      expect(page).to have_link("Find Parking")
      expect(page).to have_content("#{users[1].first_name} #{users[1].last_name}'s Profile")
      expect(page).to have_content("#{users[1].first_name}'s Bookings:")
      expect(page).to_not have_link("+")
      expect(page).to_not have_link("Edit Account")
      expect(page).to_not have_link("Delete Account")
    end
  end
end
