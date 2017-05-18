require 'spec_helper'

describe('Organization',{:type => :feature}) do
  it('takes to organization page') do
    visit('/')
    click_on("Organizations")
    expect(page).to have_content('All organizations:')
  end

  it('create a new organizations') do
    visit('/organizations')
    fill_in("name", :with => "rocket ship")
    fill_in("headquarters", :with => "Portland")
    fill_in("desc", :with => "driving a ship")
    fill_in("link", :with => "http://me.com")
    click_on("org_submit")
    expect(page).to have_content("rocket ship")
  end
end
