# frozen_string_literal: true

FactoryBot.define do
  factory :admin do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
  end

  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { Faker::Internet.password(min_length: 6) }
  end

  factory :event do
    author { association :user }
    title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph(sentence_count: 1) }
    location { Faker::Lorem.word }
    start_time { Time.zone.now }
    end_time { Time.zone.now + 1.day }
    organizer_email { Faker::Lorem.word }
    organizer_telegram { Faker::Lorem.word }
    link { Faker::Lorem.word }
  end
end
