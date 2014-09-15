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
  end
end
