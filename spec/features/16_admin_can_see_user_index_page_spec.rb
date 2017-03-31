require 'rails_helper'

feature "User visits the Users Index Page" do
  let!(:admin) {FactoryGirl.create(:admin)}
  let!(:users) { FactoryGirl.create_list(:user, 2) }
  context "As user who is an admin" do
    before { login_as(admin, scope: :user) }
    scenario "User can see the Users Index" do
      visit users_path
      save_and_open_page

      expect(page).to have_content("Users Index - ADMINS ONLY")
      expect(page).to have_link("#{users[0].email}")
      expect(page).to have_link("#{users[1].email}")
    end
  end
  context "As user who is not an admin" do
    before { login_as(users[0], scope: :user) }
    scenario "User cannot see the Users Index" do
      visit users_path

      expect(page).to have_content("Users Index - ADMINS ONLY")
      expect(page).to have_content("Sorry, but you're not an admin, so you don't get access to this info.")
      expect(page).to have_content("Click the 'My Profile' link in the navbar to get back to your profile.")
    end
  end
end
