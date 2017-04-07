require 'rails_helper'

feature "User visits the Users Index Page" do
  let!(:admin) {FactoryGirl.create(:admin)}
  let!(:users) { FactoryGirl.create_list(:user, 2) }
  context "As user who is an admin" do
    before { login_as(admin, scope: :user) }
    scenario "User can see the Users Index" do
      visit users_path

      expect(page).to have_content("Users Index - ADMINS ONLY")
      expect(page).to have_link("#{users[0].email}")
      expect(page).to have_link("#{users[1].email}")
    end
  end
end
