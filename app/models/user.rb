class User < ApplicationRecord
  before_save {email.downcase!}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,format: {with: VALID_EMAIL_REGEX},
    presence: true, length: {maximum: 255},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}
  validates :name,  presence: true, length: {maximum: 50}
  has_secure_password
end
