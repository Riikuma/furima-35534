FactoryBot.define do
  factory :order do
    Faker::Config.locale = :ja
    token { 'tok_abcdefghijk00000000000000000' }
    buyer_postal_code { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture_id { Faker::Number.within(range: 2..48) }
    buyer_city { Faker::Address.city }
    buyer_address { Faker::Address.street_address }
    buyer_building { Faker::Address.secondary_address }
    buyer_phone_number { Faker::Number.number(digits: 11) }
  end
end
