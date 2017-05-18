require 'spec_helper'

describe('Event',{:type => :feature}) do
  it('takes to event page') do
    visit('/')
    click_on("Events")
    expect(page).to have_content('Add an event:')
  end
end
