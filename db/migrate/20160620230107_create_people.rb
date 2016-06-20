class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.text :urls
      t.string :timezone
      t.date :birthday
      t.text :chat_usernames
      t.text :photo
      t.text :additional_info

      t.timestamps null: false
    end
  end
end
