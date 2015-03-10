class MedicationsController < ApplicationController
  def show
    @medication = Medication.find(params[:id])
  end


  def destroy
    medication = Medication.find(params[:id])
    medication.destroy
    redirect_to root_path, notice: "Deleted medication successfully"
  end
end
