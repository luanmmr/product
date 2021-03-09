FactoryBot.define do
  factory :plan do
    name { 'Go' }
    description { 'Minha descrição' }
    product_type { create(:product_type) }
    details { 'Meus detalhes' }
    status { :activated }
  end
end
