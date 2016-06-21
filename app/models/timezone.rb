class Timezone < ActiveRecord::Base
  class << self
    def options_for_select
      Timezone.all.map{ |tz| ["#{tz.offset} : #{tz.name}", tz.id] }
    end
  end
end
