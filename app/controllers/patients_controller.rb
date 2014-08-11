class PatientsController < ApplicationController

  def index
    @patients = Patient.order(:first_name, :last_name)
  end

end