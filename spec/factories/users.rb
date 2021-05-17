FactoryBot.define do
  factory :user do
    Faker::Config.locale = :ja
    email {Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 6)
    password {password}
    password_confirmation {password}
    nickname {Faker::Name.name}
    last_name {Faker::Name.last_name}
    first_name {Faker::Name.first_name}
    last_name_kana {Faker::Name.last_kana_name}
    first_name_kana {Faker::Name.first_kana_name}
    user_birth_date {Faker::Date.between_except(from: '1930-01-01', to: "#{Time.now.year - 5}-12-31")}
  end
end