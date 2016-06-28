class AddPronounsToPerson < ActiveRecord::Migration
  def change
    add_column :people, :pronoun_nominative, :string
    add_column :people, :pronoun_oblique, :string
    add_column :people, :pronoun_possessive, :string
  end
end
