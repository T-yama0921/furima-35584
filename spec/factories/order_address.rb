FactoryBot.define do
  factory :order_address do
    postal_code      { Faker::Number.leading_zero_number(digits: 3)+"-"+Faker::Number.leading_zero_number(digits: 4) }
    shipping_area_id { Faker::Number.within(range: 1..47) }
    city             { Gimei.city.kanji }
    house_number     { Faker::Address.building_number }
    building_name    { Gimei.town.hiragana }
    phone_number     { Faker::Number.leading_zero_number(digits: 11) }
    association :user
    association :item
    token            { "tok_abcdefghijk00000000000000000" }
  end
end