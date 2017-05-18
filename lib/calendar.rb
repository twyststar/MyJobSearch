class Calendar < ActiveRecord::Base
  has_and_belongs_to_many(:openings)
  has_and_belongs_to_many(:organizations)
  has_and_belongs_to_many(:contacts)

  before_destroy :kill_all

  def days_of_month
    calendar_weeks.map do |week|
      week.map do |date|
        [date, DayStyles.new(date).to_s]
      end
    end
  end

  def calendar_weeks
    first_calendar_day = self.date.beginning_of_month.beginning_of_week(:sunday)
    last_calendar_day = self.date.end_of_month.end_of_week(:sunday)
    (first_calendar_day .. last_calendar_day).to_a.in_groups_of(7)
  end

  def self.find_date(calendar_date)
    dates = Calendar.all()
    matching_date = []
    dates.each do |date|
      date_format = date.date
      if date_format.strftime("%Y-%m-%d") == calendar_date
        matching_date.push(date.id)
      end
    end
    matching_date
  end

  def self.find_notes(calendar_date)
    dates = Calendar.all()
    notes_for_day = 0
    dates.each do |date|
      date_format = date.date
      if date_format.strftime("%Y-%m-%d") == calendar_date
        event = Calendar.find(date.id)
        if event.notes != nil
          notes_for_day = notes_for_day + 1
        end
      end
    end
    notes_for_day
  end

private

  def kill_all
    self.contacts.delete_all
    self.organizations.delete_all
    self.openings.delete_all
  end
end
