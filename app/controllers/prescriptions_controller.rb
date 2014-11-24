class PrescriptionsController < ApplicationController
  def new
    @patient = Patient.find(params[:patient_id])
    @prescription = Prescription.new
  end

  def create
    @patient = Patient.find(params[:patient_id])
    @prescription = Prescription.new(
      allowed_params.merge(:patient => @patient,
                           :prescribed_by => current_user)
    )

    if @prescription.save
      flash[:notice] = "Your prescription has been created"
      redirect_to @patient
    else
      render :new
    end

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
