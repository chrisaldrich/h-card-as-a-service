class AddPersonalWebsiteToPerson < ActiveRecord::Migration
  def change
    add_column :people, :personal_website, :string
  end
end
