require "rails_helper"

describe PrescriptionsController do
  context "POST #" do
    it "associates the prescription to the logged in user" do
      user = create_user
      patient = create_patient

      allow(controller).to receive(:current_user).and_return(user)

      prescription = {
        :medication_id => create_medication.id,
        :dosage => "4ml",
        :schedule => "every 4 hours",
        :starts_on => Time.now,
        :ends_on => Time.now + 1.day
      }

      post :create, :patient_id => patient.id, :prescription => prescription

      prescription = Prescription.last

      expect(prescription.prescribed_by).to eq(user)
    end
  end
end
