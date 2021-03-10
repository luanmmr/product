FactoryBot.define do
  factory :price do
    plan_price { 59.90 }
    plan { create(:plan) }
    periodicity { create(:periodicity) }
  end
end
