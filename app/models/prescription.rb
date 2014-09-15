class Prescription < ActiveRecord::Base
  belongs_to :medication
  belongs_to :patient

  validates :medication, :patient, :dosage, :schedule, :starts_on, :ends_on,
            :presence => true

  delegate :name, :to => :medication, :prefix => true

  def dosage_with_schedule
    "#{dosage} #{schedule}"
  end

  def dates
    "#{format_date(starts_on)} - #{format_date(ends_on)}"
  end

  private

  def format_date(date)
    date.strftime("%m/%d/%Y")
  end

end
