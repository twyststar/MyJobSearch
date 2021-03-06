require('pry')
class Contact < ActiveRecord::Base
  has_and_belongs_to_many(:organizations)
  has_and_belongs_to_many(:tags)
  has_and_belongs_to_many(:openings)
  has_and_belongs_to_many(:notes)
  has_and_belongs_to_many(:calendars)
  validates(:name, :presence => true)
  before_destroy :kill_all

  def not_org
    all_orgs = Organization.all
    all_cont_orgs = self.organizations
    remain_org = all_orgs - all_cont_orgs
  end
  def not_tag
    all_tags = Tag.all
    all_cont_tags = self.tags
    remain_tag = all_tags - all_cont_tags
  end

  def link_display
    disp = self.linkedin.split("")
    count = 8
    result=[]
    until count == 26
      result.push(disp[count])
      count +=1
    end
    return result.join('')
  end

private
  def kill_all
    self.organizations.delete_all
    self.openings.delete_all
    self.tags.delete_all
    self.notes.delete_all
    self.calendars.delete_all
  end


end
