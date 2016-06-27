class RemoveColonFromOffsetInTimezones < ActiveRecord::Migration
  def up
    Timezone.all.each do |timezone|
      timezone.offset = timezone.offset.sub(":", "")
      timezone.save!
    end
  end

  def down
    Timezone.all.each do |timezone|
      timezone.offset = timezone.offset.sub(/(\d{2})$/, ":#{$1}")
      timezone.save!
    end
  end
end
