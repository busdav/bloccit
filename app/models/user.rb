class User < ApplicationRecord
  before_save { self.email = email.downcase if email.present? }

  before_save :capitalize_name

  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  # #4
  validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
  validates :password, length: { minimum: 6 }, allow_blank: true
  # #5
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }

  # #6
  has_secure_password

  def capitalize_name
    if name
      name_array = []
      name.split.each { |name_part| name_array << name_part.capitalize }
      self.name = name_array.join(" ")
    end
  end
end
