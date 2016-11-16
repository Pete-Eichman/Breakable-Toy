require 'rails_helper'

feature "User Updates parking pass info" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:parking_pass) { FactoryGirl.create(:parking_pass, user: user) }
  before { login_as(user, scope: :user) }
  before { visit root_path }
  context "As a User on My Profile page" do
    scenario "I can click a link to bring me to my parking pass edit page" do
      click_link "My Profile"
      click_link "Edit Parking Pass"

      expect(page).to have_button "Update Parking Pass"
      expect(page).to have_field "parking_pass[pass_number]"
      expect(page).to have_field "parking_pass[address]"
      expect(page).to have_field "parking_pass[price_per_hour]"
    end
  end
  context "As a User on the parking pass Edit page" do
    scenario "I can update my parking pass info" do
      click_link "My Profile"
      click_link "Edit Parking Pass"
      fill_in("parking_pass[pass_number]", with: "33")
      fill_in("parking_pass[address]", with: "35 Harrison Ave Boston MA")
      fill_in("parking_pass[price_per_hour]", with: "2.00")
      click_button "Update Parking Pass"

      expect(page).to have_content "Parking Pass was Updated!"
      expect(page).to have_content "35 Harrison Ave Boston MA"
      expect(page).to have_content "Pass #: 33"
      expect(page).to have_content "Price Per Hour: $2.00"
      expect(page).to have_content "Pass Owner: #{user.first_name}"
    end
  end
end
