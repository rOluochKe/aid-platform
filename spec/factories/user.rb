FactoryBot.define do
    factory :user, class: User do
      id {1}
      firstname {"Jane"}
      lastname {"Doe"}
      password {"1234567"}
      email {"#{firstname}@gmail.com"}
      image {'test.jpg'}
    end

    factory :user1, class: User do
        id {2}
        firstname {"John"}
        lastname {"Doe"}
        password {"1234567"}
        email {"#{firstname}@gmail.com"}
        image {'test.jpg'}
    end
end
  
FactoryBot.define do
    factory :random_user, class: User do
      firstname {Faker::Name.first_name}
      lastname {Faker::Name.last_name}
      password {"1234567"}
      email {Faker::Internet.safe_email}
      image {'test.jpg'}
    end
end