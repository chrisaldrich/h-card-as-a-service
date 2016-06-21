class AddDomainToPerson < ActiveRecord::Migration
  def change
    add_column :people, :domain, :string
  end
end
