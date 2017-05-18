require 'spec_helper'

describe('Opening',{:type => :feature}) do
  it('takes to opening page') do
    visit('/')
    click_on("Openings")
    expect(page).to have_content('Contacts for this opening:')
  end

  it('create a new tag') do
    visit('/openings')
    fill_in("name", :with => "rocket ship")
    fill_in("location", :with => "Portland")
    fill_in("desc", :with => "driving a ship")
    fill_in("salary", :with => 1232456)
    fill_in("link", :with => "http://me.com")
    click_on("opening_submit")
    expect(page).to have_content("rocket ship")
  end
end
