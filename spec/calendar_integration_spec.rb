require 'spec_helper'

describe('Calendar',{:type => :feature}) do
  it('takes to calendar page') do
    visit('/')
    click_on(18)
    expect(page).to have_content('2017-05-18')
  end
end
