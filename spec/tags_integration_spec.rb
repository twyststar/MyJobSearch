require 'spec_helper'

describe('Tag',{:type => :feature}) do
  it('takes to tag page') do
    visit('/')
    click_on("Tags")
    expect(page).to have_content('Category/Tag Name:')
  end

  it('create a new tag') do
    visit('/tags')
    fill_in("name", :with => "rocket ship")
    click_on("tag_submit")
    expect(page).to have_content("rocket ship")
  end
end
