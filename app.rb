require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
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

get('/tags/:id') do
  @tag = Tag.find(params.fetch("id").to_i)
  erb(:single_tag)
end

get('/openings') do
  @openings = Opening.all
  @organizations = Organization.all
  erb(:openings)
end

post('/openings/new') do
  organization_id = params.fetch('organization_id', nil).to_i
  Opening.create({:name => (params[:name]), :location => (params[:location]), :desc => (params[:desc]), :salary => (params[:salary]), :link => (params[:link]), :organization_id => organization_id, :notes => (params[:notes])})
  @openings = Opening.all
  @organizations = Organization.all
  erb(:openings)
end

get('/single_opening/:id') do
  @opening = Opening.find(params.fetch("id").to_i)
  erb(:single_opening)
end

get('/organizations') do
  @contacts = Contact.all
  @organizations = Organization.all
  @tags = Tag.all()
  erb(:organizations)
end

post('/organizations/new') do
  tag_ids = (params[:tag_ids])
  new_org= Organization.create({:name => (params[:name]), :headquarters => (params[:headquarters]), :desc => (params[:desc]), :link => (params[:link])})
  tag_ids.each do |tag_id|
    tag_id.to_i
    new_org.tags.push(Tag.find(tag_id))
  end
  @organizations = Organization.all
  @tags = Tag.all()
  erb(:organizations)
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
  tag_ids.each do |tag_id|
    tag_id.to_i
    new_contact.tags.push(Tag.find(tag_id))
  end
  organization_ids.each do |organization_id|
    new_contact.organizations.push(Organization.find(organization_id))
  end
  erb(:index)
end
