require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
require('pry')

get('/') do
  @tags = Tag.all()
  if Organization.all == []
    Organization.create({:name => ('Misc'), :headquarters => ("NA"), :desc => ("Catch-all category for one-off openings."), :link => ("NA")})
  end
  @count = 0
  @starting_date = Time.now.months_since(@count).to_date
  @month = Date::MONTHNAMES[@starting_date.month]
  @simple_calendar = Calendar.new({:date => @starting_date}).days_of_month
  erb(:index)
end

post('/my_link/new') do
  my_link = My_link.create({:text => (params[:text]), :url => (params[:url])})
  redirect ('/')
end

get('/my_link/edit') do
  @links = My_link.all
  erb(:link_edit)
end

delete("/link_delete") do
  link_ids = (params[:link_ids])
  if link_ids!= nil
    link_ids.each do |link_id|
      link_id.to_i
      my_link = My_link.find(link_id)
      my_link.destroy
    end
  end
  redirect('/')
end

get('/previous_month/:counter') do
  @count = params[:counter].to_i - 1
  @starting_date = Time.now.months_since(@count).to_date
  @month = Date::MONTHNAMES[@starting_date.month]
  @simple_calendar = Calendar.new({:date => @starting_date}).days_of_month
  erb(:index)
end

get('/next_month/:counter') do
  @count = params[:counter].to_i + 1
  @starting_date = Time.now.months_since(@count).to_date
  @month = Date::MONTHNAMES[@starting_date.month]
  @simple_calendar = Calendar.new({:date => @starting_date}).days_of_month
  erb(:index)
end

get('/calendar/view/:calendar_date') do
  @calendar_date = params[:calendar_date]
  @calendar_events = Calendar.find_date(@calendar_date)
  erb(:calendar_events)
end

get('/tags') do
  @tags = Tag.all()
  erb(:tags)
end

post('/tags/new') do
  Tag.create({:name => (params[:name])})
  @tags = Tag.all()
  erb(:tags)
end

get('/single_tag/:id') do
  @tag = Tag.find(params.fetch("id").to_i)
  erb(:single_tag)
end

get('/openings') do
  @openings = Opening.all
  @contacts = Contact.all
  @organizations = Organization.all
  @tags = Tag.all()
  erb(:openings)
end

post('/openings/new') do
  tag_ids = (params[:tag_ids])
  contact_ids = (params[:contact_ids])
  notes = Note.create({:text => (params[:text])})
  organization_id = params.fetch('organization_id').to_i
  new_opening = Opening.create({:name => (params[:name]), :location => (params[:location]), :desc => (params[:desc]), :salary => (params[:salary]), :link => (params[:link]), :organization_id => organization_id})
  new_opening.notes.push(notes)
  if contact_ids!= nil
    contact_ids.each do |contact_id|
      new_opening.contacts.push(Contact.find(contact_id))
    end
  end
  if tag_ids!= nil
    tag_ids.each do |tag_id|
      tag_id.to_i
      new_opening.tags.push(Tag.find(tag_id))
    end
  end
  @openings = Opening.all
  @organizations = Organization.all
  @contacts = Contact.all
  @tags = Tag.all
  erb(:openings)
end

patch('/opening_edit/:id') do
  @opening = Opening.find(params.fetch("id").to_i)
  tag_ids = (params[:tag_ids])
  contact_ids = (params[:contact_ids])
  organization_id = params.fetch('organization_id').to_i
  @opening.update({:name => (params[:name]), :location => (params[:location]), :desc => (params[:desc]), :salary => (params[:salary]), :link => (params[:link]), :organization_id => organization_id})
  if tag_ids!= nil
    tag_ids.each do |tag_id|
      tag_id.to_i
      @opening.tags.push(Tag.find(tag_id))
    end
  end
  if contact_ids!= nil
    contact_ids.each do |contact_id|
      @opening.contacts.push(Contact.find(contact_id))
    end
  end
    redirect ('/single_opening/' + params[:id])
end

delete('/opening_edit/:id') do
  @openings = Opening.all
  @organizations = Organization.all
  @contacts = Contact.all
  @tags = Tag.all
  opening = Opening.find(params[:id])
  opening.delete
  erb(:openings)
end

post('/opening_note')do
  opening_id = (params[:opening_id]).to_i
  opening = Opening.find(opening_id)
  note = Note.create({:text => (params[:text])})
  opening.notes.push(note)
  redirect ('/single_opening/' + (params[:opening_id]))
end

get('/single_opening/:id') do
  @opening = Opening.find(params.fetch("id").to_i)
  @organization = @opening.organization
  erb(:single_opening)
end

get('/single_opening/edit/:id') do
  @opening = Opening.find(params.fetch("id").to_i)
  @organizations = Organization.all
  @contacts = Contact.all
  @tags = Tag.all()
  erb(:opening_edit)
end


get('/organizations') do
  @contacts = Contact.all
  @organizations = Organization.all
  @tags = Tag.all
  erb(:organizations)
end

post('/organizations/new') do
  tag_ids = (params[:tag_ids])
  contact_ids =(params[:contact_ids])
  new_org = Organization.create({:name => (params[:name]), :headquarters => (params[:headquarters]), :desc => (params[:desc]), :link => (params[:link])})
  if contact_ids!= nil
    contact_ids.each do |contact_id|
      new_org.contacts.push(Contact.find(contact_id))
    end
  end
  if tag_ids!= nil
    tag_ids.each do |tag_id|
      tag_id.to_i
      new_org.tags.push(Tag.find(tag_id))
    end
  end
  @organizations = Organization.all
  @contacts = Contact.all
  @tags = Tag.all()
  erb(:organizations)
end

patch('/organizations_edit/:id') do
  organization = Organization.find(params.fetch("id").to_i)
  contact_ids =(params[:contact_ids])
  tag_ids = (params[:tag_ids])
  if tag_ids!= nil
    tag_ids.each do |tag_id|
      tag_id.to_i
      organization.tags.push(Tag.find(tag_id))
    end
  end
  if contact_ids!= nil
    contact_ids.each do |contact_id|
      organization.contacts.push(Contact.find(contact_id))
    end
  end
  organization.update({:name => (params[:name]), :headquarters => (params[:headquarters]), :desc => (params[:desc]), :link => (params[:link])})
  redirect ('/single_organization/' + params[:id])
end

delete('/organizations_edit/:id') do
  @contacts = Contact.all
  @organizations = Organization.all
  @tags = Tag.all
  organization = Organization.find(params[:id].to_i)
  organization.delete
  erb(:organizations)
end

get('/single_organization/:id') do
  @organization = Organization.find(params.fetch("id").to_i)
  @openings = @organization.openings
  erb(:single_organization)
end

get('/single_organization/edit/:id') do
  @contacts = Contact.all
  @tags = Tag.all()
  @organization = Organization.find(params.fetch("id").to_i)
  erb(:organization_edit)
end

get('/contacts') do
  @contacts = Contact.all
  @organizations = Organization.all
  @tags = Tag.all()
  erb(:contacts)
end

post('/contacts/new') do
  tag_ids = (params[:tag_ids])
  organization_ids = (params[:organization_ids])
  notes = Note.create({:text => params[:text]})
  new_contact = Contact.create({:name => (params[:name]), :title => (params[:title]), :address => (params[:address]), :phone => (params[:phone]), :email => (params[:email]), :linkedin => (params[:linkedin]), :context => (params[:context])})
  new_contact.notes.push(notes)
  if tag_ids!= nil
    tag_ids.each do |tag_id|
      tag_id.to_i
      new_contact.tags.push(Tag.find(tag_id))
    end
  end
  if organization_ids!= nil
    organization_ids.each do |organization_id|
      new_contact.organizations.push(Organization.find(organization_id))
    end
  end
  redirect '/contacts'
end

get('/single_contact/:id') do
  @contact = Contact.find(params.fetch("id").to_i)

  erb(:single_contact)
end

get('/single_contact/edit/:id') do
  @contact = Contact.find(params.fetch("id").to_i)
  @organizations = Organization.all
  @tags = Tag.all()
  erb(:contact_edit)
end

patch('/contact_edit/:id') do
  contact = Contact.find(params.fetch("id").to_i)
  tag_ids = (params[:tag_ids])
  organization_ids =(params[:organization_ids])
  if tag_ids!= nil
    tag_ids.each do |tag_id|
      tag_id.to_i
      contact.tags.push(Tag.find(tag_id))
    end
  end
  if organization_ids!= nil
    organization_ids.each do |organization_id|
      contact.organizations.push(Organization.find(organization_id))
    end
  end
  contact.update({:name => (params[:name]), :title => (params[:title]), :address => (params[:address]), :phone => (params[:phone]), :email => (params[:email]), :linkedin => (params[:linkedin]), :context => (params[:context])})
    redirect ('/single_contact/' + params[:id])
end

post('/contact_note') do
  contact_id = (params[:contact_id]).to_i
  contact = Contact.find(contact_id)
  note = Note.create({:text => (params[:text])})
  contact.notes.push(note)
  redirect ('/single_contact/' + (params[:contact_id]))
end

delete('/contact_edit/:id') do
  @contacts = Contact.all
  @organizations = Organization.all
  @tags = Tag.all
  contact = Contact.find(params[:id].to_i)
  contact.delete
  erb(:contacts)
end
