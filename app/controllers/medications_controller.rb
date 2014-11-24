class MedicationsController < ApplicationController
  def show
    @medication = Medication.find(params[:id])
  end
end
