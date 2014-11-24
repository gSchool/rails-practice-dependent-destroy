class CreatePrescriptions < ActiveRecord::Migration
  def change
    create_table :prescriptions do |t|
      t.belongs_to :patient, index: true
      t.belongs_to :medication, index: true
      t.string :dosage
      t.string :schedule
      t.date :starts_on
      t.date :ends_on
    end
  end
end
