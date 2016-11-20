require 'rails_helper'

feature "Admin can edit another user's profile" do
  let!(:admin) {FactoryGirl.create(:admin)}
  let!(:users) { FactoryGirl.create_list(:user, 2) }
  before { login_as(admin, scope: :user) }
  context "As an Admin on another user's page" do
    scenario "I can see a link to click to edit the users profile" do
      visit user_path(users[1])

      expect(page).to have_content "#{users[1].first_name}'s Profile"
      expect(page).to have_link "Edit User Account"
    end
  end
end
