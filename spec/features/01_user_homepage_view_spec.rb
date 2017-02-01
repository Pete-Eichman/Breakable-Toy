require 'rails_helper'

feature "User visits the home page" do
  context "As an unauthenticated user" do
    scenario "I can view the home page" do
      visit '/'

      expect(page).to have_content "Welcome to Pokemon Type Helper!"
    end
  end
end
