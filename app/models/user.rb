class User < ApplicationRecord
  include Clearance::User

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :password, length: { minimum: 6 }
  validates :zip, presence: true, length: { minimum: 5 }
  validates :city, presence: true
  validates :email, presence: true, format: { with: /\A.*@.*\.com\z/ }, uniqueness: true
end
