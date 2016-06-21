class CreateTimezones < ActiveRecord::Migration
  def up
    create_table :timezones do |t|
      t.string :offset
      t.string :name

      t.timestamps null: false
    end
    
    ActiveSupport::TimeZone.all.each do |timezone|
      Timezone.create!(offset: timezone.formatted_offset, name: timezone.name)
    end
  end
  
  def down
    drop_table :timezones
  end
end
