require "rails_helper"

describe Prescription do
  context "validations" do
    it "requires dosages start with numbers" do
      prescription = Prescription.new(:dosage => "something")

      prescription.valid?
      expect(prescription).to have(1).error_on(:dosage)

      prescription.dosage = "1 something"

      prescription.valid?
      expect(prescription).to have(0).errors_on(:dosage)
    end

    it "requires starts on is greater than ends on" do
      prescription = Prescription.new(:starts_on => Time.now - 1.day,
                                      :ends_on => Time.now - 2.days)

      prescription.valid?
      expect(prescription).to have(1).error_on(:starts_on)

      prescription.ends_on = Time.now
      prescription.valid?
      expect(prescription).to have(0).errors_on(:starts_on)
    end
  end
end
