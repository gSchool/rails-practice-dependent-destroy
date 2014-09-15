class PrescriptionsController < ApplicationController
  def new
    @patient = Patient.find(params[:patient_id])
    @prescription = Prescription.new
  end

  def create
    @prescription = Prescription.new(
      allowed_params.merge(:patient_id => params[:patient_id])
    )

    @prescription.save!

    flash[:notice] = "Your prescription has been created"
    redirect_to patient_path(params[:patient_id])
  end


  private

  def allowed_params
    params.require(:prescription).permit(
      :medication_id,
      :dosage,
      :schedule,
      :starts_on,
      :ends_on
    )
  end
end
