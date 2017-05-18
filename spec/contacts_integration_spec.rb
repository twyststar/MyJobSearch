require 'spec_helper'

describe('Contact',{:type => :feature}) do
  it('takes to contact page') do
    visit('/')
    click_on("Contacts")
    expect(page).to have_content('The context of the contact:')
  end

  it('create a new contact') do
    visit('/contacts')
    fill_in("name", :with => "rocket pilot")
    fill_in("title", :with => "Developer")
    fill_in("address", :with => "123 Main St")
    fill_in("phone", :with => "123-456-7890")
    fill_in("email", :with => "rocket@pilot.com")
    fill_in("linkedin", :with => "http://rocketpilot.com")
    fill_in("context", :with => "pilot")
    click_on("contact_submit")
    expect(page).to have_content("rocket pilot")
  end
end
