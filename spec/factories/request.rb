FactoryBot.define do
    factory :request, class: Request do
        title {'I need your help'}
        reqtype {'material'}
        description {Faker::Lorem.sentence(word_count: 300)}
        lat {Faker::Address.latitude}
        lng {Faker::Address.longitude}
        address {Faker::Address.street_address}
        status { 0 }
        user_id { 1 }
    end

    factory :request1, class: Request do
        title {'I need your help'}
        reqtype {'material'}
        description {Faker::Lorem.sentence(word_count: 300)}
        lat {Faker::Address.latitude}
        lng {Faker::Address.longitude}
        address {Faker::Address.street_address}
        status { 0 }
        user_id { 2 }
    end
end