require 'rails_helper'

feature "Patients" do
  def create_user_and_login
    user = create_user
    patient = create_patient(:first_name => "Jeff",
                             :last_name => "Taggart")
    login(user)
  end

  scenario "User sees all patients" do
    create_user_and_login
    expect(page).to have_content("Jeff", "Taggart")
  end

  scenario "User sees a patients prescriptions" do
    create_user_and_login
    click_on("Jeff Taggart")

    expect(page).to have_content("Jeff Taggart")
    expect(page).to have_content("Prescriptions")
  end

  scenario "User can create a prescription" do
    create_user_and_login
    create_medication(:name => "Some medication")

    click_on("Jeff Taggart")
    click_on("Add Prescription")

    expect(page).to have_content("Add a prescription to Jeff Taggart")


    select "Some medication", :from => "Medication"
    fill_in "Dosage", :with => "4ml"
    fill_in "Schedule", :with => "every 4 hours"

    select "2014", :from => "prescription[starts_on(1i)]"
    select "January", :from =>   "prescription[starts_on(2i)]"
    select "1", :from =>   "prescription[starts_on(3i)]"

    select "2014", :from => "prescription[ends_on(1i)]"
    select "January", :from =>   "prescription[ends_on(2i)]"
    select "2", :from =>   "prescription[ends_on(3i)]"

    click_on "Create Prescription"

    expect(page).to have_content("Your prescription has been created")


    expect(page).to have_content("Jeff Taggart")
    expect(page).to have_content("Prescriptions")

    expect(page).to have_content("Some medication")
    expect(page).to have_content("4ml every 4 hours")
    expect(page).to have_content("01/01/2014 - 01/02/2014")
  end

end
