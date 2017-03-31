require 'rails_helper'

feature "User visits profile page and sees their parking pass" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:parking_pass) { FactoryGirl.create(:parking_pass, user: user) }
  before { login_as(user, scope: :user) }
  context "As a user who owns a parking pass" do
    scenario "I can see my parking passes" do
      visit root_path
      click_link("My Profile")

      expect(page).to have_link("Pass Page")
      expect(page).to have_link("Edit")
      expect(page).to have_link("Delete")
    end
    scenario "I can click a link to bring me to my parking pass show page." do
      visit root_path
      click_link("My Profile")
      click_link("Pass Page")

      expect(page).to have_content("Bookings:")
      expect(page).to have_content("Pass #: #{parking_pass.pass_number}")
      expect(page).to have_content("Price Per Hour: $#{parking_pass.price_per_hour}")
      expect(page).to have_content("Pass Owner: #{parking_pass.user.first_name} #{parking_pass.user.last_name}")
    end
    scenario "I can click a link to delete my parking pass" do
      visit root_path
      click_link("My Profile")
      click_link("Delete")

      expect(page).to have_content("Parking Pass was deleted!")
      expect(page).to have_link("My Profile")
      expect(page).to have_link("Sign Out")
      expect(page).to have_link("Find Parking")
      expect(page).to have_link("Edit Account")
      expect(page).to have_link("+")
      expect(page).to have_link("Delete Account")
      expect(page).to have_content("Your owned Parking Passes:")
      expect(page).to have_content("#{user.first_name}'s Bookings:")
      expect(page).to_not have_link("Pass Page")
    end
  end
end
