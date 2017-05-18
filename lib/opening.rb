class Opening < ActiveRecord::Base
  belongs_to(:organization)

  has_and_belongs_to_many(:calendars)
  has_and_belongs_to_many(:contacts)
  has_and_belongs_to_many(:notes)
  has_and_belongs_to_many(:tags)
  has_many(:interviews)

  before_destroy :kill_all

  def not_tag
    all_tags = Tag.all
    all_open_tag = self.tags
    remain_tag = all_tags - all_open_tag
  end

  def not_contact
    all_contacts = Contact.all
    all_open_contact = self.contacts
    remain_contact = all_contacts - all_open_contact
  end

  def link_display
    disp = self.link.split("")
    count = 8
    result=[]
    until count == 25
      result.push(disp[count])
      count +=1
    end
    return result.join('')
  end

private

    def kill_all
      self.tags.delete_all
      self.contacts.delete_all
      self.notes.delete_all
      self.calendars.delete_all
    end
end
