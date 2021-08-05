FactoryBot.define do
  factory :order_transaction do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { '東京都' }
    addresses { '港区１−１' }
    building { '東京ハイツ' }
    phone_number { '09012345678' }
  end
end
