require "spec_helper"

feature "Sigining in" do 
  before do
    Factory(:user, email: "ticketee@example.com")
  end

  scenario "Sigining in via confirmation" do
    open_email "ticketee@example.com", with_subject: /Confirmation/
    click_first_link_in_email
    page.should have_content("Your account was successfully confirmed")
    page.should have_content("Signed in as ticketee@example.com")
  end
end
