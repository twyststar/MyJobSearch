require('spec_helper')
require('pry')

describe(Calendar) do

  describe('#days_of_month') do
    it("returns the Calendar dates for the entire month") do
      test_month = Calendar.create(:date => Date.today)
      test_month1 = Calendar.create(:date => Date.today)
      expect(test_month.days_of_month()).to eq(test_month1.days_of_month())
    end
  end

  describe('#find_date') do
    it("returns the id of the found date") do
      test_month = Calendar.create(:date => Time.now.months_since(1).to_date)
      test_month1 = Calendar.create(:date => Date.today)
binding.pry  
      expect(Calendar.find_date('2017-05-17')).to eq(test_month1.id)
    end
  end

  describe('#openings') do
    it("returns the all the openings associated with calender") do
      test_event = Calendar.create(:date => Date.today)
      new_opening = Opening.create({:name => 'junior dev', :location => 'seattle', :desc => 'gdhkghgkghhghg', :salary => '123,456', :link => 'google.com', :organization_id => 4567, :notes => 'great'})

      test_event.openings.push(new_opening)
      new_opening2 = Opening.create({:name => 'senior dev', :location => 'seattle', :desc => 'gdhkghgkghhghg', :salary => '123,456', :link => 'google.com', :organization_id => 4567, :notes => 'great'})
      test_event.openings.push(new_opening2)
      test_event.save()

      expect(test_event.openings()).to eq([new_opening, new_opening2])
    end
  end
  describe('#organizations') do
    it("returns the all the organizations associated with calender") do
      test_event = Calendar.create(:date => Date.today)
      new_org1 = test_event.organizations.create({:name => "Google", :headquarters => "Seattle", :desc => "Rich company", :link => "google.com"})
      new_org2 = test_event.organizations.create({:name => "Amazon", :headquarters => "Seattle", :desc => "Rich company", :link => "amazon.com"})
      expect(test_event.organizations()).to eq([new_org1, new_org2])
    end
  end

end
