class Calendar < ActiveRecord::Base
  has_and_belongs_to_many(:openings)
  has_and_belongs_to_many(:organizations)

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
    matching_date = ""
    dates.each do |date|
      binding.pry
      if date == calendar_date
        matching_date = date
      end
      matching_date
    end
  end


end
