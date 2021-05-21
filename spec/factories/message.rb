FactoryBot.define do
    factory :message, class: Message do
        user_id { 1 }
        receiver_id { 2 }
        content {Faker::Lorem.sentence(word_count: 10)}
        request_id { 1 }
    end

    factory :message1, class: Message do
        user_id { 2 }
        receiver_id { 1 }
        content {Faker::Lorem.sentence(word_count: 10)}
        request_id { 1 }
    end
end