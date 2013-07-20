require 'spec_helper'

feature "Hidden Links:" do
  let(:user) { Factory(:confirmed_user) }
  let(:admin) { Factory(:admin_user) }
  let(:project) { Factory(:project) }
  let!(:ticket)  { Factory(:ticket, project: project, user: user) }

  context "Anonymous users" do
    scenario "cannot see the New Project link" do
      visit '/'
      assert_no_link_for "New Project"
    end

    scenario "cannot see the Edit Project Link" do
      visit project_path(project)
      assert_no_link_for "Edit Project"
    end

    scenario "cannot see the Delete Project Link" do
      visit project_path(project)
      assert_no_link_for "Delete Project"
    end
  end

  context "Regular users" do
    before { sign_in_as!(user) }

    scenario "cannot see the New Project link" do
      visit '/'
      assert_no_link_for "New Project"
    end

    scenario "cannot see the Edit Project Link" do
      visit project_path(project)
      assert_no_link_for "Edit Project"
    end

    scenario "cannot see the Delete Project Link" do
      visit project_path(project)
      assert_no_link_for "Delete Project"
    end

    scenario "can see the 'New ticket' link with permission" do
      define_permission!(user, "view", project)
      define_permission!(user, "create tickets", project)
      visit project_path(project)
      assert_link_for "New Ticket"
    end

    scenario "cannot see the 'New ticket' link without permission" do
      define_permission!(user, "view", project)
      visit project_path(project)
      assert_no_link_for "New Ticket"
    end

    scenario "can see the 'Edit ticket' with permission" do
      define_permission!(user, "view", project)
      define_permission!(user, "edit tickets", project)
      visit project_path(project)
      click_link ticket.title
      assert_link_for "Edit Ticket"
    end

    scenario "cannot see the 'Edit ticket' link without permission" do
      define_permission!(user, "view", project)
      visit project_path(project)
      click_link ticket.title
      assert_no_link_for "Edit Ticket"
    end

    scenario "can see the 'Delete ticket' with permission" do
      define_permission!(user, "view", project)
      define_permission!(user, "delete tickets", project)
      visit project_path(project)
      click_link ticket.title
      assert_link_for "Delete Ticket"
    end

    scenario "cannot see the 'Delete ticket' link without permission" do
      define_permission!(user, "view", project)
      visit project_path(project)
      click_link ticket.title
      assert_no_link_for "Delete Ticket"
    end
  end

  context "Admin users" do
    before { sign_in_as!(admin) }
    
    scenario "can see the New Project link" do
      visit '/'
      assert_link_for "New Project"
    end
  
    scenario "can see the Edit Project Link" do
      visit project_path(project)
      assert_link_for "Edit Project"
    end

    scenario "can see the Delete Project Link" do
      visit project_path(project)
      assert_link_for "Delete Project"
    end

    scenario "can see the New ticket link" do
      visit project_path(project)
      assert_link_for "New Ticket"
    end

    scenario "can see the Edit ticket link" do
      visit project_path(project)
      click_link ticket.title
      assert_link_for "Edit Ticket"
    end

    scenario "can see the Delete ticket link" do
      visit project_path(project)
      click_link ticket.title
      assert_link_for "Delete Ticket"
    end
  end
end
