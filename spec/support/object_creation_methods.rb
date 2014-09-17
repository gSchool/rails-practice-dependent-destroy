def create_user(overrides = {})
  User.create!({
                   name: 'Some User',
                   email: 'user@example.com',
                   password: 'password',
                   password_confirmation: 'password'
               }.merge(overrides))
end

def create_patient(overrides = {})
  Patient.create!({
                      first_name: "Some",
                      last_name: "Patient",
                  }.merge(overrides))
end

def create_medication(overrides = {})
  Medication.create!({}.merge(overrides))
end
