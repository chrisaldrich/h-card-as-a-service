class AddTimezoneIdToPerson < ActiveRecord::Migration
  def change
    remove_column :people, :timezone, :string
    add_column :people, :timezone_id, :integer
  end
end
