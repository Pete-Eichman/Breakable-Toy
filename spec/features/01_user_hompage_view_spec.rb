require 'rails_helper'

feature "user visits homepage" do
  context "and as a user" do
    scenario "I see a page" do
      user = FactoryGirl.create(:user)

      visit '/'

      expect(page).to have_content("Welcome to ParkMe!")
      expect(page).to have_no_content("Hi")
    end
  end
end
