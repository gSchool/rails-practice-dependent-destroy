class AddPrescribedByToPrescriptions < ActiveRecord::Migration
  def change
    add_column :prescriptions, :prescribed_by_id, :integer, :index => true
  end
end
