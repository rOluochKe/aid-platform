class Request < ApplicationRecord
    belongs_to :user
    has_many :volunteers, dependent: :destroy
    has_many :messages, dependent: :destroy

    validates :title, presence: true
    validates :reqtype, presence: true
    validates :description, presence: true
    validates :lat, presence: true
    validates :lng, presence: true
    validates :address, presence: true
    validates :status, presence: true
end
