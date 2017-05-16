require('spec_helper')

describe(Contact) do
  describe("#not_org") do
    it("will give the organization objects not part of the array already selected") do
      new_org1 = Organization.create({:name => "Amazon", :headquarters => "Lake Union", :desc => "as in Amazon", :link => "linkety link"})
      new_org2 = Organization.create({:name => "Microsoft", :headquarters => "Bellvue", :desc => "as in Amazon", :link => "linkety link"})
      new_org3 = Organization.create({:name => "Expedia", :headquarters => "Seattle", :desc => "as in Amazon", :link => "linkety link"})
      new_contact = Contact.create({:name => "Bob", :title => "Executive douche", :address => "123 Main", :phone => "949-234-8912", :email => "elany@google.com", :linkedin => "slkflkslds", :context => "from the thing", :notes => "hdskldslhd"})
      new_contact.organizations.push(new_org1)
      new_contact.organizations.push(new_org2)
      expect(new_contact.not_org).to(eq([new_org3]))
    end
  end
end
