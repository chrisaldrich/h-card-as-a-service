class Person < ActiveRecord::Base
  has_many :nicknames
  belongs_to :timezone

  validates :personal_website, presence: true, uniqueness: true

  before_update :generate_domain
  before_create :generate_domain
  before_update :ensure_protocol
  before_create :ensure_protocol
  after_update  :generate_nicknames
  after_create  :generate_nicknames

  PROTOCOL_REGEX = /^https*:\/\//

  def birthday
    if self.birthday_year.present? && self.birthday_month.present? && self.birthday_day.present?
      [self.birthday_year, self.birthday_month, self.birthday_day].join("-")
    elsif self.birthday_year.blank? && self.birthday_month.present? && self.birthday_day.present?
      ["-", self.birthday_month, self.birthday_day].join("-")
    elsif self.birthday_year.blank? && self.birthday_month.blank?
      nil
    elsif self.birthday_year.present? && self.birthday_month.blank?
      self.birthday_year
    end
  end

  def generate_domain
    self.domain = self.personal_website.gsub(PROTOCOL_REGEX, "").gsub(/\/*$/, "")
  end

  def ensure_protocol
    unless self.personal_website =~ PROTOCOL_REGEX
      self.personal_website = "http://#{self.personal_website}"
    end
  end

  def generate_nicknames
    self.chat_usernames.split(/,|\W/).reject{ |n| n.blank? }.each do |nickname|
      self.nicknames.find_or_create_by!(name: nickname)
    end
  end
end
