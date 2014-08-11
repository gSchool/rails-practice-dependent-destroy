class CreateMedications < ActiveRecord::Migration
  def change
    create_table :medications do |t|
      t.string :name
    end
  end
end
