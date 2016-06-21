class Person < ActiveRecord::Base
  belongs_to :timezone
  
  validates :personal_website, presence: true, uniqueness: true
  
  before_update :generate_domain
  before_create :generate_domain
  
  def generate_domain
    self.domain = self.personal_website.gsub(/https*:\/\//, "")
  end
end
