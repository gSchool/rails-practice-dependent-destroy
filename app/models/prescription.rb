class Prescription < ActiveRecord::Base
  belongs_to :medication
  belongs_to :patient

  validates :medication, :patient, :dosage, :schedule, :starts_on, :ends_on,
            :presence => true

  validate :dosage_starts_with_number

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

  def dosage_starts_with_number
    if dosage.present? && !dosage.match(/^\d/)
      errors.add(:dosage, "must start with a number")
    end 
  end

end
