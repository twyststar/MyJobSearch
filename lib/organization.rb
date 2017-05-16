class Organization < ActiveRecord::Base
  has_many(:openings)
  has_and_belongs_to_many(:tags)
  has_and_belongs_to_many(:contacts)
  has_and_belongs_to_many(:calendars)

  def not_contact
    all_contacts = Contact.all
    all_open_contact = self.contacts
    remain_contact = all_contacts - all_open_contact
  end

  def not_tag
    all_tags = Tag.all
    all_open_tag = self.tags
    remain_tag = all_tags - all_open_tag
  end
end
