FactoryBot.define do
  factory :item do
    Faker::Config.locale = :ja
    item_name { Faker::Commerce.product_name }
    item_description { Faker::Commerce.product_name }
    item_category_id { Faker::Number.within(range: 2..11) }
    item_status_id { Faker::Number.within(range: 2..7) }
    item_shipping_fee_status_id { Faker::Number.within(range: 2..3) }
    prefecture_id { Faker::Number.within(range: 2..48) }
    item_days_to_ship_id { Faker::Number.within(range: 2..4) }
    item_price { Faker::Number.within(range: 300..9_999_999) }
    association :user

    after(:build) do |item|
      item.item_image.attach(io: File.open('public/images/wooden_wall_2.jpeg'), filename: 'wooden_wall_2.jpeg')
    end
  end
end
