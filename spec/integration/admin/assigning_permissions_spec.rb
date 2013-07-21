require 'spec_helper'

feature "Assigning permissions:" do
  let!(:admin) { Factory(:admin_user) }
  let!(:user) { Factory(:confirmed_user) }
  let!(:project) { Factory(:project) }
  let!(:ticket) { Factory(:ticket, project: project, user: user) }

  before do
    sign_in_as!(admin)

    click_link "Admin"
    click_link "Users"
    click_link user.email
    click_link "Permissions"
  end

  scenario "to view a project" do
    check_permission_box "view", project

    click_button "Update"
    click_link "Sign out"

    sign_in_as!(user)
    expect(page).to have_content(project.name)
  end

  scenario "to create a ticket for a project" do
    check_permission_box "view", project
    check_permission_box "create_tickets", project


    click_button "Update"
    click_link "Sign out"

    sign_in_as!(user)
    click_link project.name
    click_link "New Ticket"
    fill_in "Title", with: "Shiny!"
    fill_in "Description", with: "Make it so!"
    click_button "Create"
    page.should have_content("Ticket has been created.")
  end

  it "to update(edit) a ticket for a project" do
    check_permission_box "view", project
    check_permission_box "edit_tickets", project

    click_button "Update"
    click_link "Sign out"

    sign_in_as!(user)
    click_link project.name
    click_link ticket.title
    click_link "Edit Ticket"
    fill_in "Title", with: "Really Shiny!"
    click_button "Update Ticket"
    page.should have_content("Ticket has been updated")
  end

  it "to delete a ticket for a project" do
    check_permission_box "view", project
    check_permission_box "delete_tickets", project

    click_button "Update"
    click_link "Sign out"

    sign_in_as!(user)
    click_link project.name
    click_link ticket.title
    click_link "Delete Ticket"
    page.should have_content("Ticket has been deleted.")
  end
end
