class Message < ApplicationRecord
    belongs_to :user
    belongs_to :request
    
    validates :content, presence: true
    validates :receiver_id, presence: true
end
