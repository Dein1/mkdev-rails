# frozen_string_literal: true

FactoryBot.define do
  factory :event do
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
