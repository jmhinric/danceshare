class RemoveAdminfromCompanies < ActiveRecord::Migration
  def change
    remove_column :companies, :admin_id
  end
end
