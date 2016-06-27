class Person < ActiveRecord::Base
  belongs_to :timezone
  
  validates :personal_website, presence: true, uniqueness: true
  
  before_update :generate_domain
  before_create :generate_domain
  before_update :ensure_protocol
  before_create :ensure_protocol
  
  PROTOCOL_REGEX = /^https*:\/\//

  def generate_domain
    self.domain = self.personal_website.gsub(PROTOCOL_REGEX, "")
  end

  def ensure_protocol
    unless self.personal_website =~ PROTOCOL_REGEX
      self.personal_website = "http://#{self.personal_website}"
    end
  end
end
