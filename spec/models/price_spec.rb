require 'rails_helper'

RSpec.describe Price, type: :model do
 describe '#presence' do
   it 'validates every field must be filled' do
     price = Price.new

     price.valid?

     expect(price.errors.full_messages).to include(
       'Periodicidade não pode ficar em branco',
       'Plano não pode ficar em branco',
       'Preço do Plano não pode ficar em branco'
     )
   end
 end

 describe '#uniqueness' do
   it 'validates that periodicity must be unique for a plan' do
     create(:price)
     price = Price.new(plan_id: 1, 
                       periodicity_id: 1)

     price.valid?

     expect(price.errors.full_messages).to include(
       'Periodicidade já está em uso'
     )
   end

   it 'only periodicity should not be unique' do
    create(:price)
    price = Price.new(periodicity_id: 1)

    price.valid?

    expect(price.errors.full_messages).to_not include(
      'Periodicidade já está em uso'
    )
   end
 end

 describe '#numericality' do
   it 'validate if plan price is a number' do
     price = Price.new(plan_price: 'teste')

     price.valid?

     expect(price.errors.full_messages).to include(
       'Preço do Plano não é um número'
     )
   end
 end
end
