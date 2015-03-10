class PatientsController < ApplicationController
  def show
    @patient = Patient.find(params[:id])
  end

  def destroy
    patient = Patient.find(params[:id])
    patient.destroy
    flash[:notice] = "Patient has been released"
    redirect_to root_path
  end
  
end
