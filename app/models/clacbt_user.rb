class ClacbtUser < ApplicationRecord
    has_secure_password
    has_many :clacbt_exams
  
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, presence: true, length: { minimum: 6 }, if: :password_digest_changed?
  end
  