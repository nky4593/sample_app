class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true,
    length: {maximum: Settings.validation.mail_max_length},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.validation.pass_min_length}
  validates :name, presence: true,
    length: {maximum: Settings.validation.name_length}

  before_save :email_downcase

  has_secure_password

  private

  def email_downcase
    self.email = email.downcase
  end
end
