require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
require('pry')

get('/login') do
  erb :sign_in, :layout => :layout_login
end

post('/login') do
  user_name = params[:username]
  password = params[:password]
  user_id = Login.find_user(user_name)
  if user_id != 0
    user = Login.find(user_id)
    if user.password == password.encrypt(:symmetric, :password => 'secret_key')
      redirect ('/')
    else
      @error_message = "Password mismatch"
      erb :sign_in, :layout => :layout_login
    end
  else
    @error_message = "Not a registered user"
    erb :sign_in, :layout => :layout_login
  end
end

post('/register') do
  user_name = params[:username]
  password = params[:password]
  user_id = Login.find_user(user_name)
  if user_id == 0
    new_user = Login.new(:user_name => user_name, :password => password)
    if new_user.save
        redirect ('/')
    else
      @error = new_user
      erb :sign_in, :layout => :layout_login
    end
  else
    @error_message = user_name + " User name is taken. Please try another user name"
    erb :sign_in, :layout => :layout_login
  end
end

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

delete("/single_tag") do
  tag_ids = (params[:tag_ids])
  if tag_ids!= nil
    tag_ids.each do |tag_id|
      tag_id.to_i
      my_tag = Tag.find(tag_id)
      my_tag.destroy
    end
  end
  redirect('/tags')
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
  new_opening = Opening.create({:name => (params[:name]), :location => (params[:location]), :desc => (params[:desc]), :salary => (params[:salary]), :link => (params[:link]), :organization_id => organization_id, :applied => false})
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
  if @opening.calendars.any?
    @opening.event_clean
  end
  tag_ids = (params[:tag_ids])
  contact_ids = (params[:contact_ids])
  applied = (params[:applied])
  organization_id = params.fetch('organization_id').to_i

  @opening.update({:name => (params[:name]), :location => (params[:location]), :desc => (params[:desc]), :salary => (params[:salary]), :link => (params[:link]), :applied => applied, :organization_id => organization_id})
  if applied == "true"
    cal_applied_date = Calendar.create({:date => Date.today, :notes => "Applied. "})
    cal_call_back = Calendar.create({:date => Time.now.days_since(14).to_date, :notes => "Two weeks since apply date. Check in. "})
    @opening.calendars.push(cal_applied_date)
    @opening.calendars.push(cal_call_back)
  end
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

post('/opening_event') do
  opening_id = (params[:opening_id])
  opening = Opening.find(opening_id.to_i)
  date = (params[:date].to_date)
  event = Calendar.create({:date => date, :notes => (params[:note])})
  opening.calendars.push(event)
  redirect ('/single_opening/' + opening_id)
end

get('/single_opening/:id') do
  @opening = Opening.find(params.fetch("id").to_i)
  @organization = @opening.organization
  erb(:single_opening)
end

get('/single_opening/edit/:id') do
  @opening = Opening.find(params.fetch("id").to_i)
  @organizations_edit = Organization.all - [@opening.organization]
  @contacts = Contact.all
  @tags = Tag.all()
  erb(:opening_edit)
end




delete("/open_tag_delete") do
  opening_id = (params[:opening_id]).to_i
  opening = Opening.find(opening_id)
  tag_ids = (params[:tag_ids])
  if tag_ids!= nil
    tag_ids.each do |tag_id|
      tag_id.to_i
      my_tag = Tag.find(tag_id)
      opening.tags.delete(my_tag)
    end
  end
  redirect('/single_opening/' + opening_id.to_s)
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

post('/organization_event') do
  organization_id = (params[:organization_id])
  organization = Organization.find(organization_id.to_i)
  date = (params[:date].to_date)
  event = Calendar.create({:date => date, :notes => (params[:note])})
  organization.calendars.push(event)
  redirect ('/single_organization/' + organization_id)
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

post('/contact_event') do
  contact_id = (params[:contact_id])
  contact = Contact.find(contact_id.to_i)
  date = (params[:date].to_date)
  event = Calendar.create({:date => date, :notes => (params[:note])})
  contact.calendars.push(event)
  redirect ('/single_contact/' + contact_id)
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

get('/events') do
  @contacts = Contact.all
  @organizations = Organization.all
  @openings = Opening.all
  @tags = Tag.all
  @calendars = Calendar.all
  erb(:events)
end

delete('/event') do
  calendar_ids = (params[:calendar_ids])
  if calendar_ids != nil
    calendar_ids.each do |cal_id|
      cal_id.to_i
      cal_to_kill = Calendar.find(cal_id)
      cal_to_kill.destroy
    end
  end
  redirect ('/events')
end
post('/new_event') do
  date = (params[:date].to_date)
  Calendar.create({:date => date, :notes => (params[:note]) })
  redirect ('/events')
end
