FactoryBot.define do
  factory :user do
    Faker::Config.locale = :ja
    transient do
      person { Gimei.name }
    end
    email { Faker::Internet.free_email }
    password { "1a#{Faker::Internet.password(min_length: 4)}" }
    password_confirmation { password }
    nickname { Faker::Name.name }
    last_name { Faker::Name.last_name }
    first_name { Faker::Name.first_name }
    last_name_kana { person.last.katakana }
    first_name_kana { person.first.katakana }
    user_birth_date { Faker::Date.between(from: '1930-01-01', to: "#{Time.now.year - 5}-12-31") }
  end
end
