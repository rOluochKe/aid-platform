class User < ApplicationRecord
  has_many :requests, dependent: :destroy
  has_many :messages, dependent: :destroy

  has_secure_password

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true
  validates :image, presence: true
  validates :password, length: { minimum: 6 }, presence: true
end
