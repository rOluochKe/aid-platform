class Volunteer < ApplicationRecord
  belongs_to :request
  belongs_to :user

  validates :request_id, presence: true
  validates :requester_id, presence: true
end