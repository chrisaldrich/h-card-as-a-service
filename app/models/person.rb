class Person < ActiveRecord::Base
  has_many :nicknames
  belongs_to :timezone

  validates :personal_website, presence: true, uniqueness: true

  before_update :generate_domain
  before_create :generate_domain
  before_update :ensure_protocol
  before_create :ensure_protocol
  before_update :generate_nicknames
  before_create :generate_nicknames

  PROTOCOL_REGEX = /^https*:\/\//

  def generate_domain
    self.domain = self.personal_website.gsub(PROTOCOL_REGEX, "")
  end

  def ensure_protocol
    unless self.personal_website =~ PROTOCOL_REGEX
      self.personal_website = "http://#{self.personal_website}"
    end
  end

  def generate_nicknames
    self.chat_usernames.split(/,|\W/).reject{ |n| n.blank? }.each do |nickname|
      Nickname.find_or_create_by!(name: nickname, person_id: self.id)
    end
  end
end
