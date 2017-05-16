require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
require('pry')
get('/') do
  if Organization.all == []
    Organization.create({:name => ('Misc'), :headquarters => ("NA"), :desc => ("Catch-all category for one-off openings."), :link => ("NA")})
  end
  erb(:index)
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
  contact_ids =(params[:contact_ids])
  organization_id = params.fetch('organization_id').to_i
  new_opening = Opening.create({:name => (params[:name]), :location => (params[:location]), :desc => (params[:desc]), :salary => (params[:salary]), :link => (params[:link]), :organization_id => organization_id, :notes => (params[:notes])})

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

get('/single_opening/:id') do
  @opening = Opening.find(params.fetch("id").to_i)
  @organization = @opening.organization
  erb(:single_opening)
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

get('/single_organization/:id') do
  @organization = Organization.find(params.fetch("id").to_i)
  @openings = @organization.openings
  erb(:single_organization)
end

get('/contacts') do
  @contacts = Contact.all
  @organizations = Organization.all
  @tags = Tag.all()
  erb(:contacts)
end

post('/contacts/new') do
  tag_ids = (params[:tag_ids])
  organization_ids =(params[:organization_ids])
  new_contact = Contact.create({:name => (params[:name]), :title => (params[:title]), :address => (params[:address]), :phone => (params[:phone]), :email => (params[:email]), :linkedin => (params[:linkin]), :context => (params[:context]), :notes => (params[:notes])})
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
  erb(:index)
end

get('/single_contact/:id') do
  @contact = Contact.find(params.fetch("id").to_i)

  erb(:single_contact)
end
