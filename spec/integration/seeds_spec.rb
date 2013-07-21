require "spec_helper"

feature "Seed Data:" do
  scenario "load the basics" do
    load Rails.root + "db/seeds.rb"
    user = User.find_by_email!("admin@ticketee.com")
    #had to put this line in because password was not comming 
    #through in the db call!!
    user.password = "password"
    sign_in_as!(user)
    page.should have_content("Ticketee Beta")
  end 
end
