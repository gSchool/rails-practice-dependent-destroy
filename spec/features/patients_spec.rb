require 'rails_helper'

feature "Patients" do
  def create_patient_and_user_and_login
    user = create_user(:name => "Some User")
    patient = create_patient(:first_name => "Jeff",
                             :last_name => "Taggart")
    login(user)
    [user, patient]
  end

  scenario "User sees all patients" do
    create_patient_and_user_and_login
    expect(page).to have_content("Jeff")
  end

  scenario "User sees a patients prescriptions" do
    create_patient_and_user_and_login
    click_on("Jeff Taggart")

    expect(page).to have_content("Jeff Taggart")
    expect(page).to have_content("Prescriptions")
  end

  scenario "User can create a prescription" do
    create_patient_and_user_and_login
    create_medication(:name => "Some medication")

    click_on("Jeff Taggart")
    click_on("Add Prescription")

    expect(page).to have_content("Add a prescription to Jeff Taggart")

    select "Some medication", :from => "Medication"
    fill_in "Dosage", :with => "4ml"
    fill_in "Schedule", :with => "every 4 hours"

    select "2014", :from => "prescription[starts_on(1i)]"
    select "January", :from => "prescription[starts_on(2i)]"
    select "1", :from => "prescription[starts_on(3i)]"

    select "2014", :from => "prescription[ends_on(1i)]"
    select "January", :from => "prescription[ends_on(2i)]"
    select "2", :from => "prescription[ends_on(3i)]"

    click_on "Create Prescription"

    expect(page).to have_content("Your prescription has been created")

    expect(page).to have_content("Jeff Taggart")
    expect(page).to have_content("Prescriptions")

    expect(page).to have_content("Some medication")
    expect(page).to have_content("4ml every 4 hours")
    expect(page).to have_content("01/01/2014 - 01/02/2014")
  end

  scenario "user can see errors on the prescription page" do
    create_patient_and_user_and_login

    click_on("Jeff Taggart")
    click_on("Add Prescription")

    expect(page).to have_content("Add a prescription to Jeff Taggart")

    click_on "Create Prescription"

    expect(page).to have_content("Medication can't be blank")
  end

  scenario "user can view user's that have prescriptions for a medication" do
    user, patient = create_patient_and_user_and_login

    other_patient = create_patient(:first_name => "John",
                                   :last_name => "Smith")

    medication = create_medication(:name => "Some medication")

    Prescription.create!(:patient => patient,
                         :medication => medication,
                         :prescribed_by => user,
                         :dosage => "4ml",
                         :schedule => "every 4 hours",
                         :starts_on => Time.parse("2014-01-01"),
                         :ends_on => Time.parse("2014-01-05"))

    Prescription.create!(:patient => other_patient,
                         :medication => medication,
                         :prescribed_by => user,
                         :dosage => "1 pill",
                         :schedule => "every 20 hours",
                         :starts_on => Time.parse("2014-02-01"),
                         :ends_on => Time.parse("2014-02-05"))


    visit root_path

    click_on "Some medication"

    within("tr", :text => "Jeff Taggart") do
      expect(page).to have_content("4ml every 4 hours")
      expect(page).to have_content("01/01/2014 - 01/05/2014")
      expect(page).to have_content("Some User")
    end

    within("tr", :text => "John Smith") do
      expect(page).to have_content("1 pill every 20 hours")
      expect(page).to have_content("02/01/2014 - 02/05/2014")
      expect(page).to have_content("Some User")
    end
  end

end
