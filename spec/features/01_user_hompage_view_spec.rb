require 'rails_helper'

feature "user visits homepage" do
  context "and as a user" do
    scenario "I see a page" do

      visit '/'

      expect(page).to have_content("Welcome to ParkMe!")
    end
  end
end
