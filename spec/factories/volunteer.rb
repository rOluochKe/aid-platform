FactoryBot.define do
    factory :volunteer, class: Volunteer do
        user_id { 2 } # the person volunteering
        requester_id { 1 } # the person that created the request
        request_id { 1 } # request id
    end

    factory :volunteer1, class: Volunteer do
        user_id { 1 }
        requester_id { 2 }
        request_id { 2 }
    end
end