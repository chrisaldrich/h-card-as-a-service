class ChangeBirthdayToYearMonthDayAttributes < ActiveRecord::Migration
  def change
    remove_column :people, :birthday
    add_column :people, :birthday_year, :string
    add_column :people, :birthday_month, :string
    add_column :people, :birthday_day, :string
  end
end