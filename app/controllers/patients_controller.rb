class PatientsController < ApplicationController
  def show
    @patient = Patient.find(params[:id])
  end

  def destroy
    patient = Patient.find(params[:id])
    patient.destroy
    flash[:notice] = "Patient and prescriptions successfully removed"
    redirect_to root_path
  end
end
