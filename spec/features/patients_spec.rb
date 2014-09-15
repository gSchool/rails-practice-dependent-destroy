require 'rails_helper'
require 'capybara/rails'

feature "Patients" do

  scenario "User sees all patients" do
    user = create_user
    patient = create_patient
    login(user)

    expect(page).to have_content(patient.first_name, patient.last_name)
  end

  scenario "User sees a patients prescriptions" do
    user = create_user
    patient = create_patient
    login(user)

    click_on(patient.full_name) 

    expect(page).to have_content(patient.full_name)
    expect(page).to have_content("Prescriptions")
  end

end
